import UIKit

final class WeatherListViewController: UIViewController {
    
    var presenter: WeatherListPresenterProtocol?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        self.setupViews()
        self.setupTableView()
        self.setupUI()
    }
    
    private let refreshControl = UIRefreshControl()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.register(WeatherViewCell.self)
        self.tableView.register(LoadingCell.self)
        self.tableView.register(ErrorViewCell.self)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar(with: .default)
        
        self.changeIconNavigationButtonRight()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .clear
        self.title = L10n.titleNavigationWeather
    }
    
    
    private func setupUnitTemperature() {
        self.presenter?.changeUnitTemperature()
    }
    
    private func navigationMap() {
        self.presenter?.showMapWeather()
    }
    
    private func changeIconNavigationButtonRight () {
        if let unitTemp = self.presenter?.getUnitTemperature() {
            setupNavigationButtonRightWeather(iconType: unitTemp, actionButtonTemperature: {
                self.setupUnitTemperature()
            }) {
                self.navigationMap()
            }
        }
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        self.presenter?.viewDidLoad()
    }
}

extension WeatherListViewController: WeatherListViewProtocol {
    
    func reloadData() {
        self.refreshControl.endRefreshing()
        self.tableView.reloadData()
    }
    
    func showUnitTemperature() {
        self.reloadData()
        self.changeIconNavigationButtonRight()
    }
}

extension WeatherListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter?.numberOfSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weather = presenter?.getWeather(with: indexPath.row) else { return UITableViewCell() }
        
        switch weather {
        case .loading:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as LoadingCell
            return cell
        case let .error(error):
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ErrorViewCell
            cell.setupView(error: error) {
                self.presenter?.viewDidLoad()
            }
            return cell
        case let .cell(weather):
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as WeatherViewCell
            if let unitTemp = self.presenter?.getUnitTemperature() {
              cell.setupWeather(weather: weather, outputTempType: unitTemp)
            }
            
            return cell
        }
        
    }
}

extension WeatherListViewController: CodeViewProtocol {
    
    func buildViewHierarchy() {
        self.view.addSubview(self.tableView)
    }
    
    func setupConstraints() {
        
        self.tableView
            .topAnchor(equalTo: self.view.topAnchor)
            .leadingAnchor(equalTo: self.view.leadingAnchor)
            .trailingAnchor(equalTo: self.view.trailingAnchor)
            .bottomAnchor(equalTo: self.view.bottomAnchor)
    }
}

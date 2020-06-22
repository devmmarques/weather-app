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
        WeatherListWireframe.createWeatherListModule(controller: self)
        self.presenter?.viewDidLoad()
        self.setupViews()
        self.setupTableView()
        self.setupUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(WeatherViewCell.self)
        self.tableView.register(LoadingCell.self)
        self.tableView.register(ErrorViewCell.self)
    }
    
    private func setupUI() {
        self.view.backgroundColor = .clear
    }
}

extension WeatherListViewController: WeatherListViewProtocol {
    
    func reloadData() {
        self.tableView.reloadData()
    }
}


extension WeatherListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
            cell.setupWeather(weather: weather)
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
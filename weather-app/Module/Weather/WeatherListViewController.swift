import UIKit

final class WeatherListViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupTableView()
        self.setupUI()
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(WeatherViewCell.self)
    }
    
    private func setupUI() {
        self.view.backgroundColor = .clear
    }
}


extension WeatherListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension WeatherListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as WeatherViewCell
        return cell
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

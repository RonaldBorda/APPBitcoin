//
//  ViewController.swift
//  APIBitcoin
//
//  Created by Ronald Meliton Borda Bernaola on 11/07/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let bitcoinViewModel: BitcoinViewModel = BitcoinViewModel()
    var filterData: [Rate] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task{
            await setUpData()
        }
        setUpView()
    }
    func setUpData() async{
        await bitcoinViewModel.getDataFromAPI()
        filterData = bitcoinViewModel.bitcoins
        print(bitcoinViewModel.bitcoins)
        tableView.reloadData()
    }
    func setUpView(){
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
            let bitcoin = filterData[indexPath.row]
            cell.textLabel?.text = bitcoin.name
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(filterData[indexPath.row].name)
    }
}
extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData = searchText.isEmpty
        ? bitcoinViewModel.bitcoins
        : bitcoinViewModel.bitcoins.filter({ (bitcoin: Rate) -> Bool in
            return bitcoin.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        tableView.reloadData()
    }
}

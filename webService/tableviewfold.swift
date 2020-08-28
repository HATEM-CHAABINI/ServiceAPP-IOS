//
//  tableviewfold.swift
//  webService
//
//  Created by Hatem Chaabini on 20/01/2020.
//  Copyright © 2020 Hatem Chaabini. All rights reserved.
//
/*
import UIKit
import Alamofire
import AlamofireImage
import FoldingCell

class tableviewfold:BaseViewController,UITableViewDataSource,UITableViewDelegate  {
    var tvShows:NSArray = []

        enum Const {
            static let closeCellHeight: CGFloat = 179
            static let openCellHeight: CGFloat = 488
            static let rowsCount = 10
        }
        
        var cellHeights: [CGFloat] = []

        // MARK: Life Cycle
        override func viewDidLoad() {
            super.viewDidLoad()
            setup()
            fetchTvShows()

        }

        func fetchTvShows(){
            let Usercon = UserDefaults.standard
                   var k : String
                   
                           k = Usercon.object(forKey: "email") as! String
                     
            Alamofire.request("http://localhost:3000/personnoc/"+k).responseJSON{
                
                response in
                
                
                
              print(response.result.value as Any)
                
                self.tvShows = response.result.value as! NSArray
                
                self.tableView.reloadData()
                
            }
            
        }
        // MARK: Helpers
        private func setup() {
            cellHeights = Array(repeating: Const.closeCellHeight, count: Const.rowsCount)
            tableView.estimatedRowHeight = Const.closeCellHeight
            tableView.rowHeight = UITableView.automaticDimension
            tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
            if #available(iOS 10.0, *) {
                tableView.refreshControl = UIRefreshControl()
                tableView.refreshControl?.addTarget(self, action: #selector(refreshHandler), for: .valueChanged)
            }
        }
        
        // MARK: Actions
        @objc func refreshHandler() {
            let deadlineTime = DispatchTime.now() + .seconds(1)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: { [weak self] in
                if #available(iOS 10.0, *) {
                    self?.tableView.refreshControl?.endRefreshing()
                }
                self?.tableView.reloadData()
            })
        }
    }
    // MARK: - TableView

    extension TableViewController {

        override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
            return tvShows.count
        }

        override func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            guard case let cell as DemoCell = cell else {
                return
            }

            cell.backgroundColor = .clear

            if cellHeights[indexPath.row] == Const.closeCellHeight {
                cell.unfold(false, animated: false, completion: nil)
            } else {
                cell.unfold(true, animated: false, completion: nil)
            }
            let tvShow = tvShows[indexPath.row] as! Dictionary<String,Any>

            cell.number = indexPath.row
            cell.nom = (tvShow["name"] as? String)!
            cell.imagepr = tvShow["image"] as! String
            cell.nomcl = (tvShow["name"] as? String)!
            cell.metier = (tvShow["metier"] as? String)!
            cell.prixx = (tvShow["prix"] as? Float)!
            cell.ido = "\(tvShow["id"] as! Int)"
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath) as! FoldingCell
            let durations: [TimeInterval] = [0.26, 0.2, 0.2]
            cell.durationsForExpandedState = durations
            cell.durationsForCollapsedState = durations
            return cell
        }

        override func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return cellHeights[indexPath.row]
        }

        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            let cell = tableView.cellForRow(at: indexPath) as! FoldingCell

            if cell.isAnimating() {
                return
            }

            var duration = 0.0
            let cellIsCollapsed = cellHeights[indexPath.row] == Const.closeCellHeight
            if cellIsCollapsed {
                cellHeights[indexPath.row] = Const.openCellHeight
                cell.unfold(true, animated: true, completion: nil)
                duration = 0.5
            } else {
                cellHeights[indexPath.row] = Const.closeCellHeight
                cell.unfold(false, animated: true, completion: nil)
                duration = 0.8
            }

            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
                tableView.beginUpdates()
                tableView.endUpdates()
                
                // fix https://github.com/Ramotion/folding-cell/issues/169
                if cell.frame.maxY > tableView.frame.maxY {
                    tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
                }
            }, completion: nil)
        }
    }
*/

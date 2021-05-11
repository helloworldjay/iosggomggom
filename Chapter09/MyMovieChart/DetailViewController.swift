//
//  DetailViewController.swift
//  MyMovieChart
//
//  Created by prologue on 2018. 3. 18..
//  Copyright © 2018년 SQLPRO. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
  
  @IBOutlet var wv: WKWebView!
  var mvo: MovieVO! // 목록 화면에서 전달하는 영화 정보를 받을 변수
}

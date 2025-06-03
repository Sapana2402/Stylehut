//
//  ViewController.swift
//  stylehut
//
//  Created by MACM26 on 21/05/25.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var trendingProductCollectionView: UICollectionView!
    
    
    @IBOutlet weak var couponsTextImage: UIImageView!
    @IBOutlet weak var gifView: AnimatedImageView!
    @IBOutlet weak var couponsCodeSecond: UIImageView!
    @IBOutlet weak var couponsCodeOne: UIImageView!
    @IBOutlet weak var autoSlider: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var currentIndex = 0
       var sliderTimer: Timer?
    
    
    let product = ProductViewNodel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        loadAssets()
        autoSlider.delegate = self
        autoSlider.dataSource = self
        autoSlider.collectionViewLayout = UICollectionViewFlowLayout()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: autoSlider.frame.width, height: autoSlider.frame.height)
        autoSlider.collectionViewLayout = layout
        autoSlider.isPagingEnabled = true
        autoSlider.showsHorizontalScrollIndicator = false
        

        pageControl.numberOfPages = k.homeScreen.autoSliderData.count
              pageControl.currentPage = 0

              startAutoScroll()
        
        configure()
        loadData()
        
      
    }

    func startAutoScroll() {
         sliderTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(moveToNextSlide), userInfo: nil, repeats: true)
     }
    
    @objc func moveToNextSlide() {
        guard k.homeScreen.autoSliderData.count > 0 else { return }

        currentIndex = (currentIndex + 1) % k.homeScreen.autoSliderData.count
         let indexPath = IndexPath(item: currentIndex, section: 0)
         autoSlider.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
         pageControl.currentPage = currentIndex
     }
    
    func loadAssets() {
        let gifURL = URL(string: k.assets.giftCard.cashBack)!
        gifView.kf.setImage(with: gifURL)
        
        let url = URL(string: k.assets.images.fieldscouponsTextImage)!
        couponsTextImage.kf.setImage(with: url)
        
        
        let url1 = URL(string: k.assets.images.couponsCodeOne)!
        couponsCodeOne.kf.setImage(with: url1)
        
        
        let url2 = URL(string: k.assets.images.couponsCodeSecond)!
        couponsCodeSecond.kf.setImage(with: url2)
    }
    
    // ScrollView Delegate Methods
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        currentIndex = page
        pageControl.currentPage = currentIndex
        startAutoScroll() // restart auto scroll after manual swipe
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        sliderTimer?.invalidate() // stop auto scroll when user starts dragging
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            startAutoScroll()
        }
    }

    func configure() {
        trendingProductCollectionView.delegate = self
        trendingProductCollectionView.dataSource = self
        trendingProductCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        trendingProductCollectionView.register(UINib(nibName: k.allProductCellIdentifier, bundle: nil), forCellWithReuseIdentifier: k.allProductCellIdentifier)
    }
    
    func loadData() {
            Task{
                await self.product.getProducts {
                    DispatchQueue.main.async {
                                  self.trendingProductCollectionView.reloadData()
                              }

                }
            }
      
    }
}

//extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        product.productsData.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = trendingProductCollectionView.dequeueReusableCell(withReuseIdentifier: k.allProductCellIdentifier, for: indexPath) as! ProductListCollectionViewCell
//        cell.setProductDetails(model: product.productsData[indexPath.row])
//        return cell
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let padding: CGFloat = 10
//        let itemsPerRow: CGFloat = 2
//        let totalPadding = padding * (itemsPerRow + 1)
//        let availableWidth = trendingProductCollectionView.frame.width - totalPadding
//        let itemWidth = availableWidth / itemsPerRow
//        let size = trendingProductCollectionView.frame.width
//        return CGSize(width: itemWidth, height: itemWidth * 1.5) // Adjust height as needed
//    }
//
//    
////    func collectionView(_ collectionView: UICollectionView,
////                        layout collectionViewLayout: UICollectionViewLayout,
////                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
////        return 5
////    }
////
////    func collectionView(_ collectionView: UICollectionView,
////                        layout collectionViewLayout: UICollectionViewLayout,
////                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
////        return 5
////    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//    }
//
//    
//}



//extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        k.homeScreen.autoSliderData.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = autoSlider.dequeueReusableCell(withReuseIdentifier: k.autoSliderCollectionViewCell, for: indexPath) as! AutoSliderCollectionViewCell
//        let sliderItem = k.homeScreen.autoSliderData[indexPath.item]
//        if let url = URL(string: sliderItem.imageURL){
//            cell.posterImage.kf.setImage(with: url)
//        }
//        return cell
//    }
//    
//    
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        return CGSize(width: autoSlider.frame.width, height: autoSlider.frame.width)
////    }
//    
//    
//}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == trendingProductCollectionView {
            return product.productsData.count
        } else if collectionView == autoSlider {
            return k.homeScreen.autoSliderData.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == trendingProductCollectionView {
            let cell = trendingProductCollectionView.dequeueReusableCell(withReuseIdentifier: k.allProductCellIdentifier, for: indexPath) as! ProductListCollectionViewCell
            cell.setProductDetails(model: product.productsData[indexPath.row])
            return cell
        } else if collectionView == autoSlider {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: k.autoSliderCollectionViewCell, for: indexPath) as! AutoSliderCollectionViewCell
            let sliderItem = k.homeScreen.autoSliderData[indexPath.item]
            if let url = URL(string: sliderItem.imageURL) {
                cell.posterImage.kf.setImage(with: url)
            }
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == trendingProductCollectionView {
            let padding: CGFloat = 10
            let itemsPerRow: CGFloat = 2
            let totalPadding = padding * (itemsPerRow + 1)
            let availableWidth = collectionView.frame.width - totalPadding
            let itemWidth = availableWidth / itemsPerRow
            return CGSize(width: itemWidth, height: itemWidth * 1.5)
        }
        else if collectionView == autoSlider {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        return CGSize.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == trendingProductCollectionView {
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}


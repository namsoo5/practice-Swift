//
//  ViewController.swift
//  prac_ios13
//
//  Created by 남수김 on 2021/04/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var colors: [UIColor] = [.red, .orange, .cyan, .green, .blue, .brown, .darkGray, .purple]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.contentInset = .init(top: 20, left: 0, bottom: 0, right: 0)
        
        // MARK: - NSCollectionLayoutDimension
        // absolute -  고정크기
        // estimated - 최소크기
        // fractionalHeight - 포함된 그룹안의 세로 비율만큼의 크기
        // fractionalWidth - 포함된 그룹안의 가로 비율만큼의 크기
        let size = NSCollectionLayoutSize(widthDimension: .absolute(100),
                                          heightDimension: .fractionalHeight(0.3))
        
        // MARK: - NSCollectionLayoutItem
        // Cell or Supplementary
        let item = NSCollectionLayoutItem(layoutSize: size)
        let badgeItem = supplementaryItem(size: size)
        // MARK: - NSCollectionLayoutGroup
        // basic unit of layout
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: 4)
        group.interItemSpacing = .fixed(10)
        
        // MARK: - NSCollectionLayoutSection
        // section's layout
        // additional cool features
//        let section = NSCollectionLayoutSection(group: group)
        let section = nestedCollectionView()
//        boundarySupplementary(section: section)
        
        // MARK: - UICollectionViewCompositionalLayout
        // repeating
        // per-section
        let layout = UICollectionViewCompositionalLayout(section: section)
        collectionView.collectionViewLayout = layout
    }
    
    // 벳지
    func supplementaryItem(size: NSCollectionLayoutSize) -> NSCollectionLayoutItem {
        collectionView.register(BadgeView.self,
                                forSupplementaryViewOfKind: "badge",
                                withReuseIdentifier: "BadgeView")
        // MARK: - NSCollectionLayoutSupplementaryItem
        // 벳지나 프레임같이 시각적 장식을 추가하는데 사용됨
        // badges, frame
        // anchored to item or group
        let badgeAnchor = NSCollectionLayoutAnchor(edges: [.top, .trailing],
                                                   fractionalOffset: .init(x: 0.3, y: -0.3))
        
        let badgeSize = NSCollectionLayoutSize(widthDimension: .absolute(20),
                                               heightDimension: .absolute(20))
        
        
        let badge = NSCollectionLayoutSupplementaryItem(layoutSize: badgeSize,
                                                        elementKind: "badge",
                                                        containerAnchor: badgeAnchor)
        let badgeItem = NSCollectionLayoutItem(layoutSize: size, supplementaryItems: [badge])
        return badgeItem
    }
    
    func boundarySupplementary(section: NSCollectionLayoutSection) {
        collectionView.register(HeaderView.self,
                                forSupplementaryViewOfKind: "header",
                                withReuseIdentifier: "HeaderView")
        collectionView.register(FooterView.self,
                                forSupplementaryViewOfKind: "footer",
                                withReuseIdentifier: "FooterView")
        // MARK: - NSCollectionLayoutBoundarySupplementaryItem
        // 헤더나 푸터뷰를 추가할때 사용됨
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: "header",
                                                                 alignment: .top)
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(22))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize,
                                                                 elementKind: "footer",
                                                                 alignment: .bottom)
        // 헤더뷰가 계속 떠잇도록 해주는 프로퍼티
        header.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [header, footer]
    }
    
    func nestedCollectionView() -> NSCollectionLayoutSection {
        
        // MARK: - Nested CollectionViews
        let leadingSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                                 heightDimension: .absolute(100))
        let leadingItem = NSCollectionLayoutItem(layoutSize: leadingSize)
        
        let trailingSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .absolute(100))
        // absolute가 먹히질않는 이슈가있음.. 고정되지않고 group의 크기에 맞게 늘어남
        let trailingItem = NSCollectionLayoutItem(layoutSize: trailingSize)
        let trailingGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                                       heightDimension: .fractionalHeight(0.5))
        let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: trailingGroupSize,
                                                             subitem: trailingItem,
                                                             count: 3)
        let topGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .fractionalHeight(0.5))
        let topGroup = NSCollectionLayoutGroup.horizontal(layoutSize: topGroupSize,
                                                          subitems: [leadingItem, trailingGroup])
        
        let bottomSmallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .fractionalHeight(0.3))
        let bottomBigItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .fractionalHeight(0.7))
        
        let bottomSmallItem = NSCollectionLayoutItem(layoutSize: bottomSmallItemSize)
        let bottomBigItem = NSCollectionLayoutItem(layoutSize: bottomBigItemSize)
        let bottomGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                     heightDimension: .fractionalHeight(0.5))
        let bottomGroup = NSCollectionLayoutGroup.vertical(layoutSize: bottomGroupSize,
                                                             subitems: [bottomSmallItem, bottomBigItem])
        
        let containerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                                        heightDimension: .fractionalHeight(1))
        let containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: containerGroupSize,
                                                                subitems: [topGroup, bottomGroup])
        
        let section = NSCollectionLayoutSection(group: containerGroup)
        // continuous - 일반적 이동가능
        // continuousGroupLeadingBoundary - 무조건 전페이지의 leading으로이동
        // groupPaging - 가까운 그룹으로 페이징효과(leading에 맞춰짐)
        // groupPagingCentered - 그룹의 센터로 이동
        // none - 스크롤 x
        // paging - 컬렉션뷰기준 페이징
        section.orthogonalScrollingBehavior = .continuous
        return section
    }

}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = colors[indexPath.item % colors.count]
        
        cell.subviews.forEach { $0.removeFromSuperview() }
        let label: UILabel = {
            $0.text = "\(indexPath)"
            $0.textColor = .white
            return $0
        }(UILabel())
        cell.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == "badge" {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "BadgeView", for: indexPath)
            view.backgroundColor = .red
            view.layer.cornerRadius = 10
            return view
        } else if kind == "footer" {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FooterView", for: indexPath)
            view.backgroundColor = .gray
            return view
        } else if kind == "header" {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath)
            view.backgroundColor = .purple
            
            let label: UILabel = {
                $0.text = "헤더뷰"
                $0.textColor = .white
                return $0
            }(UILabel())
            view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            return view
        } else {
            return .init()
        }
    }
}

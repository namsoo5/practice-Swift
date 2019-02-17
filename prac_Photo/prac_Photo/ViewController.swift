//
//  ViewController.swift
//  prac_Photo
//
//  Created by 남수김 on 17/02/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PHPhotoLibraryChangeObserver {
    @IBOutlet weak var tableView: UITableView!
    
    var fetchResult: PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    let cellIdentifier: String = "cell"
    
    //어떤 행을 편집할수있게할것인가(밀었을때기능)
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //편집할 내용
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let asset: PHAsset = self.fetchResult[indexPath.row]
            
            //해당 에셋사진 삭제, 삭제확인창
            PHPhotoLibrary.shared().performChanges({PHAssetChangeRequest.deleteAssets([asset] as NSArray)}, completionHandler: nil)
        }
    }
    
    // 포토라이브러리 변화시
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: fetchResult)
            else { return }
        
        fetchResult = changes.fetchResultAfterChanges  //어떤것이 바꼇는지
        
        //바꼇으면 테이블뷰 다시 리로드
        OperationQueue.main.addOperation {
            self.tableView.reloadSections(IndexSet(0...0), with: .automatic)
        }
    }
    
    //사진가져오기
    func requestCollection(){
        let cameraRoll: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        
        guard let cameraRollCollection = cameraRoll.firstObject else {
            return
        }
        
        let fetchOptions = PHFetchOptions()
        //최신순 정렬
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        //결과를 변수에 저장
        self.fetchResult = PHAsset.fetchAssets(in: cameraRollCollection, options: fetchOptions)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //사진 접근허가상태
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized:
            print("접근 허가")
            self.requestCollection()
                self.tableView.reloadData()
        case .denied:
            print("접근 불허")
        case .notDetermined:
            print("아직 응답하지않음")
            PHPhotoLibrary.requestAuthorization({ (status) in
                switch status {
                case .authorized:
                    print("사용자가 허가함")
                    self.requestCollection()
                    
                    OperationQueue.main.addOperation {  // reload는 메인스레드에서만 작동할수있다오류 해결
                        self.tableView.reloadData()
                    }
                    
                case .denied:
                    print("사용자가 불허함")
                default: break
                }
            })
        case .restricted:
            print("접근 제한")
        }
        
        PHPhotoLibrary.shared().register(self) //포토라이브러리 변화시 딜리게이트 호출
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchResult?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        let asset: PHAsset = fetchResult.object(at: indexPath.row)
        
        //이미지 설정
        imageManager.requestImage(for: asset,
                                  targetSize: CGSize(width: 30, height: 30),
                                  contentMode: .aspectFill, options: nil,
                                  resultHandler: { image, _ in
                                    cell.imageView?.image = image
        })
        
        return cell
    }
    

}


//
//  CacheSample.swift
//  SwiftUIContinuedLearning
//
//  Created by dofxmine on 23.03.2025.
//

import SwiftUI

class CacheViewModel: ObservableObject {
    
    @Published var startingImage: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    @Published var infoMessage: String = ""
    let imageName: String = "anya"
    let manager = CacheManager.instance
    
    init() {
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder() {
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let image = startingImage else { return }
        infoMessage = manager.add(image: image, name: imageName)
    }
    
    func removeFromCache() {
        infoMessage = manager.remove(name: imageName)
    }
    
    func getFromCache() {
        if let returnedImage = manager.get(name: imageName) {
            cachedImage = returnedImage
            infoMessage = "Image found in cache"
        } else {
            infoMessage = "Image not found in cache"
        }
    }
}

class CacheManager {
    static let instance = CacheManager()
    private init() {}
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // ~100 MB
        return cache
    }()
    
    func add(image: UIImage, name: String) -> String {
        imageCache.setObject(image, forKey: name as NSString)
        return "Added to Cache"
    }
    
    func remove(name: String) -> String {
        imageCache.removeObject(forKey: name as NSString)
        return "Removed from Cache"
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}

struct CacheSample: View {
    
    @StateObject var vm: CacheViewModel = .init()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.secondary.opacity(0.3).ignoresSafeArea()
                
                VStack {
                    if let image = vm.startingImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 400, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.vertical, 40)
                    }
                    
                    Text(vm.infoMessage)
                    
                    HStack {
                        Button {
                            vm.saveToCache()
                        } label: {
                            Text("Save to Cache")
                                .font(.headline)
                                .foregroundStyle(.wb)
                                .padding()
                                .background(Color.yellow)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        Button {
                            vm.removeFromCache()
                        } label: {
                            Text("Delete from Cache")
                                .font(.headline)
                                .foregroundStyle(.wb)
                                .padding()
                                .background(Color.accentColor)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    Button {
                        vm.getFromCache()
                    } label: {
                        Text("Get from Cache")
                            .font(.headline)
                            .foregroundStyle(.wb)
                            .padding()
                            .background(Color.pink)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
                    if let image = vm.cachedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 400, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.vertical, 40)
                            .shadow(color: .white, radius: 10)
                    }
                    
                    Spacer()
                }
                .navigationTitle("Cache Sample")
            }
        }
    }
}

#Preview {
    CacheSample()
}

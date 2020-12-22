import UIKit
import Nuke

/// Tried SwiftSVG also, but it rendered images badly
import SVGKit

protocol ImageService {

    func fetch(_ url: URL?, for target: ImageTarget, placeholder: UIImage)
}

class DefaultImageService: ImageService {

    func fetch(_ url: URL?, for target: ImageTarget, placeholder: UIImage) {
        target.imageView?.image = placeholder

        ImageDecoderRegistry.shared.register { context in
            let isSVG = context.urlResponse?.url?.absoluteString.hasSuffix(".svg") ?? false
            return isSVG ? ImageDecoders.Empty() : nil
        }

        ImagePipeline.shared.loadImage(with: url!) { result in
            guard
                let imageView = target.imageView,
                let data = try? result.get().container.data,
                let image = SVGKImage(data: data).uiImage
            else { return }

            imageView.image = image
        }
    }
}

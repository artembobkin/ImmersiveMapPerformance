// Copyright (c) 2025-2026 ImmersiveMap contributors.
// SPDX-License-Identifier: MIT

import Foundation

/// The two tile services under measurement. The hosted ImmersiveMap endpoint
/// is public and needs nothing. The Mapbox token comes from the environment
/// or, failing that, from the gitignored `LocalSecrets.plist` at the root of
/// this repository, read live off the checkout where the process can see it
/// (simulator) and from the copy the "Bundle LocalSecrets" build phase put
/// into the app bundle on a physical device. Nothing here is ever committed.
enum BenchSecrets {
    static let immersiveMapTileTemplate = "https://immersivemap.dev/tiles/{z}/{x}/{y}.mvt"

    static func mapboxAccessToken() -> String? {
        value(forKey: "MAPBOX_ACCESS_TOKEN")
    }

    private static func value(forKey key: String) -> String? {
        if let value = ProcessInfo.processInfo.environment[key], value.isEmpty == false {
            return value
        }
        if let value = NSDictionary(contentsOf: BenchCheckout.localSecrets)?[key] as? String, value.isEmpty == false {
            return value
        }
        guard let bundled = Bundle.main.url(forResource: "LocalSecrets", withExtension: "plist") else {
            return nil
        }
        let value = NSDictionary(contentsOf: bundled)?[key] as? String
        return (value?.isEmpty == false) ? value : nil
    }
}

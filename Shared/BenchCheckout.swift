// Copyright (c) 2025-2026 ImmersiveMap contributors.
// SPDX-License-Identifier: MIT

import Foundation

/// Where the bench lives on disk and where the engine under measurement is.
/// This repository is a sibling of the ImmersiveMap checkout, and both
/// Xcode projects reference the package as `../ImmersiveMap`. The paths are
/// derived from this source file, so they are only meaningful where the
/// checkout is reachable (the simulator, or a Mac run); on a device the
/// caller falls back to what the build phase bundled.
enum BenchCheckout {
    /// The root of this repository: `Shared/` is one level below it.
    static let root = URL(fileURLWithPath: #filePath)
        .deletingLastPathComponent()
        .deletingLastPathComponent()

    /// The ImmersiveMap package checkout the bench builds against.
    static let engine = root.deletingLastPathComponent().appendingPathComponent("ImmersiveMap")

    /// The gitignored secrets file at the root of this repository.
    static let localSecrets = root.appendingPathComponent("LocalSecrets.plist")
}

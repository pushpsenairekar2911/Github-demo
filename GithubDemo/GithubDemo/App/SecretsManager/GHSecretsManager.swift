//
//  SecretsManager.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 23/05/25.
//

import Foundation

/// A utility for securely accessing secrets from a local `Secrets.plist` file.
public enum SecretsManager {
    
    /// Retrieves the GitHub API token from `Secrets.plist` in the main bundle.
    ///
    /// - Returns: A `String` containing the GitHub API token, or `nil` if the file is missing or improperly formatted.
    public static var githubToken: String? {
        guard
            let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist"),
            let data = try? Data(contentsOf: url),
            let plist = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any]
        else {
            // Return nil if file is not found or deserialization fails
            return nil
        }

        // Extract the token from the plist dictionary
        return plist["GITHUB_API_TOKEN"] as? String
    }
}

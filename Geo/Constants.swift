//
//  Constants.swift
//  Geo
//
//  Created by Damian Durzyński on 17/03/2022.
//

import Foundation

struct K {
 
    static let appName = "Geo"
    static let appLogoImageName = "shippingbox.fill"
    
    static let signOut = "Sign out"
    static let signIn = "Sign in"
    static let signUp = "Sign up"
    
    struct UserDefaultsKeys {
        
        static let meters = "Meters"
        static let miles = "Miles"
        static let name = "name"
        static let email = "email"
        
    }
    
    struct OnboardingVC {
        static let next = "Next"
        static let getStarted = "Get Started!"
    }
    
    struct Login {
        static let email = "Email"
        static let password = "Password"
        static let name = "Name"
        static let login = "Login"
        static let register = "Register"
        
        static let signInButtonTitleText = "No account yet? Sign up"
        
        static let signInErrorTitleText = "Sign In Error"
        static let signInErrorMessageText = "Your email or password is incorrect. Please try again."
        
        static let signUpErrorEmailTitleText = "Incorrect email address"
        static let signUpErrorEmailMessageText = "The email you entered is incorrect. Please try again."
        
        static let signUpErrorNameTitleText = "Incorrect username"
        static let signUpErrorNameMessageText = "The username you entered is incorrect. Please try again."
        
        static let signUpErrorPassowordTitleText = "Incorrect password"
        static let signUpErrorPassowordMessageText = "The password you entered is incorrect. Please try again."
    }
    
    struct MainTabBar {
        
        static let homeTitle = "Home"
        static let homeImageName = "house.fill"
        
        static let mapTitle = "Map"
        static let mapImageName = "map.fill"
        
        static let listTitle = "List"
        static let listImageName = "list.bullet"
        
        static let settingsTitle = "Settings"
        static let settingsImageName = "gearshape.fill"
        
    }
    
    struct HomeVC {
        
        static let exploreLabelText = "Explore places near you!"
        static let refreshControlText = "Pull to refresh"
        static let welcomeLabelText = "Welcome"
    }
    
    struct MapVC {
        
        static let title = "Map"
        static let annotationID = "PlaceAnnotationView"
        static let annotationImageName = "mappin.circle.fill"
    }
    
    struct ListVC {
        static let title = "List"
        static let refreshControlText = "Pull to refresh"
        static let allPlacesSectionHeaderText = "All places"
    }
    
    struct SettingsVC {
        static let title = "Settings"
        
        static let preferencesSectionText = "Preferences"
        static let unitsOptionText = "Units"
        
        static let userSectionText = "User"
        static let signOutOptionText = "Sign out"
        static let signOutOptionImageName = "person.fill"
    }
    
    struct UnitSettingsVC {
        static let title = "Units"
    
        static let unitCellID = "UnitsCell"
    }

    struct PlaceDetailVC {
        static let difficulty = "Difficulty"
        static let size = "Size"
        static let hint = "Hint"
        static let description = "Description"
    }
    
    struct ViewModelKeys {
        
        static let kilometers = "Kilometers"
        static let miles = "Miles"
        
        static let firstSlideAnimationName = "world"
        static let firstSlideText = "Explore the world."
        
        static let secondSlideAnimationName = "mapa"
        static let secondSlideText = "Discover amazing places."
        
        static let thirdSlideAnimationName = "box-empty"
        static let thirdSlideText = "Find unforgettable things!"
        
        static let easy = "Easy"
        static let medium = "Medium"
        static let hard = "Hard"
    }

}

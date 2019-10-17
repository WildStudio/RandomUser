# The RandomUser App for iPhone  


## General information
This repository contains the Technical Test for Apps Developer from Adevinta.


## Coding Style Guide

This code follows the [Ray Wenderlich Swift Style Guide](https://github.com/raywenderlich/swift-style-guide)


## Architecture

Following the MVVM (Model View ViewModel) architecture with repositories, at the presentation layer. Network and Model layer follow a modular approach so they can be reused. 


## Testing

Testing is done with the help of protocols for all View Models. Also both the newtwork and model layer contains unit test and integration tests. Testing at presentation layer can be improved adding UI tests and some sort of integration tests. There's also left the CI setup.


## Branching Strategy

Branching strategy follows [GitFlow] (https://datasift.github.io/gitflow/IntroducingGitFlow.html)


## Dependencies

This projects make use of the following dependencies through [Swift Package Manager](https://github.com/apple/swift-package-manager/tree/master/Documentation)

* [SDWebImage](https://github.com/SDWebImage/SDWebImage)

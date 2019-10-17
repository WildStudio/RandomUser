# The RandomUser App for iPhone  


## General information
This repository contains the Technical Test for Apps Developer from Adevinta.


## Coding Style Guide

This code follows the [Ray Wenderlich Swift Style Guide](https://github.com/raywenderlich/swift-style-guide)


## Architecture

Following the MVVM (Model View ViewModel) architecture with repositories, at the presentation layer. ViewModel are where the view business logic is added. An ViewModel only communicates with repositories and view controllers. We are using delegate in this layer to communicate withview controllers. Our Network and Model layer follow a modular approach so they can be reused. When referring to modules we are referring to the idea of a single package of code. Modules can be compiled on therir own. When referring to frameworks we are referring to the delivery mechanism of a module; i.e. a dynamically linked library containing executable code and resources.


## Testing

Testing is done with the help of protocols for all View Models. Also both the network and model layer are unit tested and integration tests have been added. Testing at presentation layer can be improved adding UI tests and some sort of integration tests. There's also left to do the CI setup.


## Branching Strategy

Branching strategy follows [GitFlow](https://datasift.github.io/gitflow/IntroducingGitFlow.html)


## Dependencies

This projects make use of the following dependencies through [Swift Package Manager](https://github.com/apple/swift-package-manager/tree/master/Documentation)

* [SDWebImage](https://github.com/SDWebImage/SDWebImage)

## Usage

In order to ran this app open RandomUser.xcworkspace, choose RandomUser scheme and press run (cmd+R) either with a test device or an iPhone simulator (Minimum deployment target is iOS13)

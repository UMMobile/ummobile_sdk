## 0.0.1-beta1
> Release date: 08/Oct/2021
* First version

## 0.0.1-beta2
> Release date: 11/Oct/2021
* Adds catalogue section
* Adds some functions for the academic section
* Rename `UMMobileAPI` to `UMMobileSDK`
* Rename `getUser()` to `getInformation()`

## 0.0.1-beta3
> Release date: 12/Oct/2021
* Adds all academic section
* Adds notifications section
* Export utils functions

## 0.0.1-beta4
> Release date: 13/Oct/2021
* Adds questionnaire section
* Adds tests for utils functions
* Adds test coverage
* Refactors `phone` field to optional.

## 0.0.1-beta5
> Release date: 14/Oct/2021
* Adds calendar
* Refactor code

## 0.0.1-beta6
> Release date: 20/Oct/2021
* Adds payment
* Adds `keyLabel` getter for enums
* Adds explicit return type for `toJson()`

## 0.0.1-beta7
> Release date: 21/Oct/2021
* Adds Conéctate
* Updates to work with `queries` arguments
* Rename Archive to Documents

## 0.0.1-beta8
> Release date: 21/Oct/2021
* Fixes not exporting Communication individual class

## 0.0.1
> Release date: 25/Oct/2021
* API models: all models were mapped with better implementation for flutter.
* Types: all useful types were mapped with better implementation for flutter (_see `Enum` section in examples_).
* UMMobile API fully implemented:
  * Catalogue:
    * Rules
    * Countries
    * Calendar
  * Communication (Conéctate):
    * News
    * Events
    * Blog
    * Stories
  * Questionnaire (COVID):
    * Save answer
    * Read answers
    * Read extra information
    * Update extra information
    * Validate answer & extra information
    * Validate responsive letter
  * Academic:
    * Documents
    * Semesters
    * Global average
  * Financial:
    * Balances
    * Movements
  * User:
    * Information
    * Picture
  * Auth:
    * Token

## 0.0.2
> Release date: 26/Oct/2021
* Fixes error saving questionnaires
* Adds validation for `RecentCountry` constructor
* Adds `RecentCountry.city` & `RecentCountry.country` constructor

## 0.0.3-beta1
> Release date: 26/Oct/2021
* Updates ummobile_custom_http package to 0.0.3-beta1

## 0.0.3-beta2
> Release date: 29/Oct/2021
* Updates ummobile_custom_http package to 0.0.3-beta2

## 0.0.3
> Release date: 02/Nov/2021
* Updates ummobile_custom_http package to 0.0.3
* Fixes dynamic return to typed one

## 0.0.4
> Release date: 03/Nov/2021
* Adds `markAsReceived` function for user notifications

## 0.0.5
> Release date: 04/Nov/2021
* Fixes error mapping stories
  * Map dates from string to DateTime
  * Map media types from integer

## 0.0.6
> Release date: 08/Nov/2021
* Fixes error mapping dates
  * Use `DateTime.parse()` instead of `DateTime()`

## 0.0.7
> Release date: 09/Nov/2021
* Deletes deprecated functions
  * `UMMobileNotifications.sendAnalytics()`
* Improves usage of `UMMobileNotifications._update()` to improve `UMMobileNotifications.markAsReceived()` usage.
  * To update only `received` field now use another public endpoint to avoid error with expired access token.

## 0.0.8
> Release date: 22/Nov/2021
* Fixes error converting DateTime to JSON
* Adds support for documents pages
* Updates examples

## 0.0.9
> Release date: 26/Nov/2021
* Adds sandbox support

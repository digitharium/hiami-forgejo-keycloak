# Template Repository

[![License: BSD3](https://img.shields.io/badge/License-BSD3-blue.svg)](https://opensource.org/license/bsd-3-clause/)

[![Trigger Jenkins Pipe](https://github.com/digitharium/hiami-forgejo-keycloak/actions/workflows/main.yml/badge.svg)](https://github.com/digitharium/hiami-forgejo-keycloak/actions/workflows/main.yml)

## Introduction

This repository is a template for all the repositories that will be used at the hackathon 2024 part of the symposium.

## Contributors

* @Gallypette
* @Chrisr3d
* @DavidCruciani

## Instructions

# Authentication in Forgejo using Keycloak

After the installation of keycloak and forgejo

## Part 1

### Keycloak

- Create a Realm
  <img src="http://hdoc.csirt-tooling.org/uploads/upload_b57b83e2dacd4f5dff3ae47ec0757bfd.png" title="" alt="" width="318">

- Create a Client
  
  - Use "forgejo" as "Client ID"
  - Tap Next
  - Check "Client authentication"
  - Tap Next
  - Enter http://YOUR-FORGEJO-IP:YOUR-FORGEJO-PORT/* for "Valid redirect URIs"
  - Enter http://YOUR-FORGEJO-IP:YOUR-FORGEJO-PORT/ for "Web origins"
  - Tap Save

- Now go in credentials tab and save the client secret
  
  - Remark: this tab does not appears if the "Client authentication" is no set in the previous step.
    
    <img src="http://hdoc.csirt-tooling.org/uploads/upload_5764ce81b291eb90de65b9f8324d765e.png" title="" alt="" width="1002">

- Create a user

- Add a new password by going in credentials tab after the user creation
  
  - Set password
  - Put temporary as off

## Part 2

### Forgejo

- Connect as admin user

- Click on the right top corner on your profile pic, go in site administration
  
  <img src="http://hdoc.csirt-tooling.org/uploads/upload_f72b4b915f4237356e306c1daba9987f.png" title="" alt="" width="175">

- Under "Identity and Access" go in "Authentication sources"

- Click on "Add Authentification Source"
  
  - Select "OAuth2" in "Authentication type"
  - Enter "Keycloak" in "Authentication name"
  - Select "OpenID Connect" in "OAuth2 Provider"
  - In "Client ID" tap "forgejo". This need to be the same name as the "Client ID" in keycloack
  - In "Client Secret" enter the client secret you save earlier 
  - In "OpenID Connect Auto Discovery URL" enter http://YOUR-KEYCLOAK-IP:YOUR-KEYCLOAK-PORT/realms/YOUR-REALM-NAME/.well-known/openid-configuration
  - Now save your configuration

![](http://hdoc.csirt-tooling.org/uploads/upload_c35cc627d4c1b1fc24cf9b25df1350bd.png)

## Part 3

### Forgejo

- Always on site administration under "Identity and Access" go in "User accounts"
- Create a new user

## Part 4

Sign out from forgejo and sign in with Keycloak
<img title="" src="http://hdoc.csirt-tooling.org/uploads/upload_637748f9dce89b73d4c61530c20a6eaa.png" alt="" width="786">

You, normally, arrived on a keycloack webpage with a form to login

Enter credentials for the user you want to authenticate on keycloak

Now you are redirect on forgejo with credentials again. Click on "Link to Existing account". Here you'll link the keycloak account to the forgejo account

Enter credentials for the user you want to authenticate on forgejo

You might be asked to update your password.

And That's it, You have finished.

## Authorization

We did not success in having authorization to work with keycloak. The crux of the issue is that neither `forgejo` nor `gitea` support nested structures for roles.
See the following issues:
https://github.com/go-gitea/gitea/issues/10016
https://codeberg.org/forgejo/forgejo/issues/1756

The answer lies in mapping roles to a flat token claim.

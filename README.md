# Authentication in Forgejo using Keycloak

[![License: BSD3](https://img.shields.io/badge/License-BSD3-blue.svg)](https://opensource.org/license/bsd-3-clause/)

[![Trigger Jenkins Pipe](https://github.com/digitharium/hiami-forgejo-keycloak/actions/workflows/main.yml/badge.svg)](https://github.com/digitharium/hiami-forgejo-keycloak/actions/workflows/main.yml)

## Introduction

This repository was initially started as part of the hackathon 2024 part of the symposium to create integration between Keycloak and Forgejo.

## Contributors

* @Gallypette
* @Chrisr3d
* @DavidCruciani

## Instructions

First Install Keycloak and Forgejo by changing directory to folders keycloak and Forgejo and run the following command in each

```docker compose up```

## Manual Configuration

### Part 1: Keycloak Configuration

- Create a Realm

<img src="media/create_realm.png" alt="Create Realm" title="Create Realm" width="318" height="auto">

- Create a Client
  
  - Use "OpenID Connect" as "Client Type"
  - Use "forgejo" as "Client ID"
  - Tap Next
  - Make sure "Client authentication" is set to "On"
  - Tap Next
  - Enter http://YOUR-FORGEJO-IP:YOUR-FORGEJO-PORT/* for "Valid redirect URIs"
  - Enter http://YOUR-FORGEJO-IP:YOUR-FORGEJO-PORT/ for "Web origins"
  - Tap Save

- Now go in credentials tab and save the client secret

  <img src="media/client_secret.png" alt="Client Secret" title="Client Secret" width="1002" height="auto">
  
  *Remark: this tab does not appears if the "Client authentication" is no set in the previous step.*

- Create a user

- Add a new password by going in credentials tab after the user creation
  
  - Set password
  - Put temporary as off


### Part 2: Forgejo Configuration

- Connect as admin user

- Click on the right top corner on your profile pic, go in site administration

  <img src="media/site_admin.png" alt="Site Admin" title="Site Admin" width="175" height="auto">

- Under "Identity and Access" go in "Authentication sources"

- Click on "Add Authentification Source"
  
  - Select "OAuth2" in "Authentication type"
  - Enter "Keycloak" in "Authentication name"
  - Select "OpenID Connect" in "OAuth2 Provider"
  - In "Client ID" tap "forgejo". This need to be the same name as the "Client ID" in keycloack
  - In "Client Secret" enter the client secret you saved earlier 
  - In "OpenID Connect Auto Discovery URL" enter http://YOUR-KEYCLOAK-IP:YOUR-KEYCLOAK-PORT/realms/YOUR-REALM-NAME/.well-known/openid-configuration
  - Now save your configuration
admin_view
 <img src="media/admin_view.png" alt="Admin View" title="Admin View" width="800" height="auto">


### Part3: Forgejo Create Account

- Always on site administration under "Identity and Access" go in "User accounts"
- Create a new user

### Part 4: Forgejo Logout and Keycloak Login

Sign out from Forgejo and sign in with Keycloak

 <img src="media/sign_in.png" alt="Sign In" title="Sign In" width="800" height="auto">

You, normally, arrived on a keycloack webpage with a form to login

Enter credentials for the user you want to authenticate on keycloak

Now you are redirect on Forgejo with credentials again. Click on "Link to Existing account". Here you'll link the keycloak account to the Forgejo account

Enter credentials for the user you want to authenticate on forgejo

You might be asked to update your password.

And That's it, You have finished.

## Authorization

We did not success in having authorization to work with keycloak. The crux of the issue is that neither `forgejo` nor `gitea` support nested structures for roles.
See the following issues:
https://github.com/go-gitea/gitea/issues/10016
https://codeberg.org/forgejo/forgejo/issues/1756

The answer lies in mapping roles to a flat token claim.

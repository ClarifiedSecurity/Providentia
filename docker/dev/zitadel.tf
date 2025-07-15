terraform {
  required_providers {
    zitadel = {
      source  = "zitadel/zitadel"
      version = "2.2.0"
    }

    local = {
      source = "hashicorp/local"
      version = "2.5.3"
    }
  }

  backend "local" {
    path = "/terraformstate/zitadel.tfstate"
  }
}

variable "ZITADEL_LOCATION" {
  type = string
}

provider "zitadel" {
  domain           = var.ZITADEL_LOCATION
  insecure         = "true"
  port             = "80"
  jwt_profile_file = "dynamic/zitadel-admin-sa.json"
}

resource "zitadel_org" "default" {
  name = "Providentia"
}

resource "zitadel_project" "default" {
  name                     = "Providentia"
  org_id                   = zitadel_org.default.id
  project_role_assertion   = true
  project_role_check       = true
  has_project_check        = true
  private_labeling_setting = "PRIVATE_LABELING_SETTING_ENFORCE_PROJECT_RESOURCE_OWNER_POLICY"
}

resource "zitadel_project_role" "super_admin" {
  org_id       = zitadel_org.default.id
  project_id   = zitadel_project.default.id
  role_key     = "Super_Admin"
  display_name = "Superadmin"
  group        = ""
}

resource "zitadel_project_role" "user" {
  org_id       = zitadel_org.default.id
  project_id   = zitadel_project.default.id
  role_key     = "User"
  display_name = "user"
  group        = ""
}

resource "zitadel_project_role" "environment_creator" {
  org_id       = zitadel_org.default.id
  project_id   = zitadel_project.default.id
  role_key     = "Environment_Creator"
  display_name = "Environment_Creator"
  group        = ""
}

resource "zitadel_project_role" "te_admin" {
  org_id       = zitadel_org.default.id
  project_id   = zitadel_project.default.id
  role_key     = "TE_Admin"
  display_name = "TE_Admin"
  group = ""
}

resource "zitadel_project_role" "te_organizer" {
  org_id       = zitadel_org.default.id
  project_id   = zitadel_project.default.id
  role_key     = "TE_Organizer"
  display_name = "TE_Organizer"
  group = ""
}

resource "zitadel_project_role" "te_developer" {
  org_id       = zitadel_org.default.id
  project_id   = zitadel_project.default.id
  role_key     = "TE_Developer"
  display_name = "TE_Developer"
  group = ""
}

resource "zitadel_project_role" "te_rt_member" {
  org_id       = zitadel_org.default.id
  project_id   = zitadel_project.default.id
  role_key     = "TE_RT_Member"
  display_name = "TE_RT_Member"
  group = ""
}

resource "zitadel_project_role" "te_bt_member" {
  org_id       = zitadel_org.default.id
  project_id   = zitadel_project.default.id
  role_key     = "TE_BT_Member"
  display_name = "TE_BT_Member"
  group = ""
}

resource "zitadel_project_role" "providentia_environment_creator" {
  org_id       = zitadel_org.default.id
  project_id   = zitadel_project.default.id
  role_key     = "Providentia_Environment_Creator"
  display_name = "Providentia_Environment_Creator"
  group = ""
}

resource "zitadel_application_oidc" "default" {
  project_id = zitadel_project.default.id
  org_id     = zitadel_org.default.id

  name                         = "Providentia"
  redirect_uris                = ["http://*/**"]
  response_types               = ["OIDC_RESPONSE_TYPE_CODE"]
  grant_types                  = ["OIDC_GRANT_TYPE_AUTHORIZATION_CODE"]
  post_logout_redirect_uris    = []
  app_type                     = "OIDC_APP_TYPE_WEB"
  auth_method_type             = "OIDC_AUTH_METHOD_TYPE_NONE"
  version                      = "OIDC_VERSION_1_0"
  clock_skew                   = "0s"
  dev_mode                     = true
  access_token_type            = "OIDC_TOKEN_TYPE_BEARER"
  access_token_role_assertion  = true
  id_token_role_assertion      = true
  id_token_userinfo_assertion  = true
  additional_origins           = []
  skip_native_app_success_page = false
}

resource "local_file" "foo" {
  content  = "OIDC_CLIENT_ID=${zitadel_application_oidc.default.client_id}"
  filename = "dynamic/env"
}

resource "zitadel_human_user" "providentia_noaccess" {
  org_id                       = zitadel_org.default.id
  user_name                    = "providentia.noaccess"
  email                        = "providentia.noaccess@localhost"
  display_name                 = "providentia.noaccess"
  first_name                   = "Providentia"
  last_name                    = "Noaccess"
  is_email_verified            = true
  initial_password             = "Password1!"
  initial_skip_password_change = true
}

resource "zitadel_human_user" "providentia_admin" {
  org_id                       = zitadel_org.default.id
  user_name                    = "providentia.admin"
  email                        = "providentia.admin@localhost"
  display_name                 = "providentia.admin"
  first_name                   = "Providentia"
  last_name                    = "Admin"
  is_email_verified            = true
  initial_password             = "Password1!"
  initial_skip_password_change = true
}

resource "zitadel_user_grant" "providentia_admin" {
  org_id     = zitadel_org.default.id
  project_id = zitadel_project.default.id
  user_id    = zitadel_human_user.providentia_admin.id
  role_keys  = ["User", "Super_Admin"]
}

resource "zitadel_human_user" "teadmin" {
  org_id                       = zitadel_org.default.id
  user_name                    = "providentia.teadmin"
  email                        = "providentia.teadmin@localhost"
  display_name                 = "providentia.teadmin"
  first_name                   = "Providentia"
  last_name                    = "Admin"
  is_email_verified            = true
  initial_password             = "Password1!"
  initial_skip_password_change = true
}

resource "zitadel_user_grant" "teadmin" {
  org_id     = zitadel_org.default.id
  project_id = zitadel_project.default.id
  user_id    = zitadel_human_user.teadmin.id
  role_keys  = ["User", "TE_Admin"]
}

resource "zitadel_human_user" "providentia_rt" {
  org_id                       = zitadel_org.default.id
  user_name                    = "providentia.rt"
  email                        = "providentia.rt@localhost"
  display_name                 = "providentia.rt"
  first_name                   = "Red"
  last_name                    = "Team"
  is_email_verified            = true
  initial_password             = "Password1!"
  initial_skip_password_change = true
}

resource "zitadel_user_grant" "providentia_rt" {
  org_id     = zitadel_org.default.id
  project_id = zitadel_project.default.id
  user_id    = zitadel_human_user.providentia_rt.id
  role_keys  = ["User", "TE_RT_Member"]
}

resource "zitadel_human_user" "providentia_dev" {
  org_id                       = zitadel_org.default.id
  user_name                    = "providentia.dev"
  email                        = "providentia.dev@localhost"
  display_name                 = "providentia.dev"
  first_name                   = "Green"
  last_name                    = "Team"
  is_email_verified            = true
  initial_password             = "Password1!"
  initial_skip_password_change = true
}

resource "zitadel_user_grant" "providentia_dev" {
  org_id     = zitadel_org.default.id
  project_id = zitadel_project.default.id
  user_id    = zitadel_human_user.providentia_dev.id
  role_keys  = ["User", "TE_Developer"]
}

resource "zitadel_human_user" "providentia_bt" {
  org_id                       = zitadel_org.default.id
  user_name                    = "providentia.bt"
  email                        = "providentia.bt@localhost"
  display_name                 = "providentia.bt"
  first_name                   = "Blue"
  last_name                    = "Team"
  is_email_verified            = true
  initial_password             = "Password1!"
  initial_skip_password_change = true
}

resource "zitadel_user_grant" "providentia_bt" {
  org_id     = zitadel_org.default.id
  project_id = zitadel_project.default.id
  user_id    = zitadel_human_user.providentia_bt.id
  role_keys  = ["User", "TE_BT_Member"]
}

resource "zitadel_human_user" "providentia_organizer" {
  org_id                       = zitadel_org.default.id
  user_name                    = "providentia.organizer"
  email                        = "providentia.organizer@localhost"
  display_name                 = "providentia.organizer"
  first_name                   = "Random"
  last_name                    = "Team"
  is_email_verified            = true
  initial_password             = "Password1!"
  initial_skip_password_change = true
}

resource "zitadel_user_grant" "providentia_organizer" {
  org_id     = zitadel_org.default.id
  project_id = zitadel_project.default.id
  user_id    = zitadel_human_user.providentia_organizer.id
  role_keys  = ["User", "TE_Organizer"]
}

resource "zitadel_human_user" "providentia_personal1" {
  org_id                       = zitadel_org.default.id
  user_name                    = "providentia.personal1"
  email                        = "providentia.personal1@localhost"
  display_name                 = "providentia.personal1"
  first_name                   = "Personal"
  last_name                    = "User 1"
  is_email_verified            = true
  initial_password             = "Password1!"
  initial_skip_password_change = true
}

resource "zitadel_user_grant" "providentia_personal1" {
  org_id     = zitadel_org.default.id
  project_id = zitadel_project.default.id
  user_id    = zitadel_human_user.providentia_personal1.id
  role_keys  = ["User", "Environment_Creator"]
}

resource "zitadel_human_user" "providentia_personal2" {
  org_id                       = zitadel_org.default.id
  user_name                    = "providentia.personal2"
  email                        = "providentia.personal2@localhost"
  display_name                 = "providentia.personal2"
  first_name                   = "Personal"
  last_name                    = "User 2"
  is_email_verified            = true
  initial_password             = "Password1!"
  initial_skip_password_change = true
}

resource "zitadel_user_grant" "providentia_personal2" {
  org_id     = zitadel_org.default.id
  project_id = zitadel_project.default.id
  user_id    = zitadel_human_user.providentia_personal2.id
  role_keys  = ["User", "Environment_Creator"]
}

resource "zitadel_human_user" "providentia_personal3" {
  org_id                       = zitadel_org.default.id
  user_name                    = "providentia.personal3"
  email                        = "providentia.personal3@localhost"
  display_name                 = "providentia.personal3"
  first_name                   = "Personal"
  last_name                    = "User 3"
  is_email_verified            = true
  initial_password             = "Password1!"
  initial_skip_password_change = true
}

resource "zitadel_user_grant" "providentia_personal3" {
  org_id     = zitadel_org.default.id
  project_id = zitadel_project.default.id
  user_id    = zitadel_human_user.providentia_personal3.id
  role_keys  = ["User", "Environment_Creator"]
}

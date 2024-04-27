provider "proxmox" {
  pm_api_url          = "https://10.3.3.10:8006/api2/json"
  pm_api_token_id     = "tf-user@pve!terraform-provisioner"
  pm_api_token_secret = "13ee86a8-68e3-4862-b896-32af61185d66"
  pm_tls_insecure     = true
  pm_debug            = false
  pm_parallel         = 3
  pm_log_enable       = false
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
}

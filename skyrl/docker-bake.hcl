# ==============================
# Skyrl Official + Yotta Wrapper 构建
# ==============================

variable "PUBLISHER"  { default = "yottalabsai" }
variable "TAG_SUFFIX" { default = "20260115" }

# 更新为 SkyRL 官方镜像
variable "BASE_IMAGE" { default = "novaskyai/skyrl-train-ray-2.51.1-py3.12-cu12.8" }

# 组：default 只构建一个 skyrl 目标
group "default" {
  targets = ["skyrl"]
}

# ==============================
# SkyRL Official + Yotta Wrapper
# ==============================
target "skyrl" {
  description = "Official SkyRL Docker image with Yotta tools"
  dockerfile  = "Dockerfile"
  platforms   = ["linux/amd64"]

  tags = [
    "${PUBLISHER}/skyrl-yotta:cu128-ray2511-skyrl-${TAG_SUFFIX}",
  ]


  contexts = {
    scripts = "../../container-template"
    proxy   = "../../container-template/proxy"
    logo    = "../../container-template"
  }

  args = {
    BASE_IMAGE = "${BASE_IMAGE}"
  }
}

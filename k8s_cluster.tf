resource "oci_containerengine_cluster" "k8s_cluster" {
  compartment_id     = var.compartment_id
  kubernetes_version = var.kubernetes_version
  name               = "k8s-cluster"
  vcn_id             = module.vcn.vcn_id
  
  endpoint_config {
    is_public_ip_enabled = true
    subnet_id            = oci_core_subnet.vcn_public_subnet.id
  }
  
  options {
    add_ons {
      is_kubernetes_dashboard_enabled = false
      is_tiller_enabled               = false
    }
    kubernetes_network_config {
      pods_cidr     = "10.244.0.0/16"
      services_cidr = "10.96.0.0/16"
    }
    service_lb_subnet_ids = [oci_core_subnet.vcn_public_subnet.id]
  }
}

resource "oci_containerengine_node_pool" "k8s_node_pool" {
  cluster_id         = oci_containerengine_cluster.k8s_cluster.id
  compartment_id     = var.compartment_id
  kubernetes_version = var.kubernetes_version
  name               = "k8s-node-pool"
  
  node_config_details {
    placement_configs {
      availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
      subnet_id           = oci_core_subnet.vcn_private_subnet.id
    }
    size = 2
  }

  node_shape = "VM.Standard.A1.Flex"

  node_shape_config {
    memory_in_gbs = 12
    ocpus         = 2
  }

  node_source_details {
    image_id    = "ocid1.image.oc1.ca-montreal-1.aaaaaaaav2lqujlk3e3i3h2efre2ttsvippxy54kgn34vsx4plvco5nj2yta" # Oracle-Linux-7.9-aarch64-2023.04.28-0-OKE-1.26.2-607
    source_type = "image"
  }

  initial_node_labels {
    key   = "name"
    value = "k8s-cluster"
  }

}

resource "google_compute_instance" "default" {
  name         = "my-website-vm"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Needed for external IP
    }
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    apt-get update
    apt-get install -y apache2
    mkdir -p /var/www/html
    echo "Deploying website..."
    cat <<EOF > /var/www/html/index.html
    <!DOCTYPE html>
    <html>
    <head>
      <title>My Personal Website</title>
      <link rel="stylesheet" href="style.css">
    </head>
    <body>
      <h1>Hello from GCP!</h1>
      <script src="script.js"></script>
    </body>
    </html>
    EOF

    cat <<EOF > /var/www/html/style.css
    body { background-color: lightblue; }
    h1 { color: navy; }
    EOF

    cat <<EOF > /var/www/html/script.js
    function talkToMe() {
      alert("Hello from your cloud website!");
    }
    EOF

    systemctl restart apache2
  EOT
}

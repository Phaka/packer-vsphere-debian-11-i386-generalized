pipeline {
    options {
        disableConcurrentBuilds()
        copyArtifactPermission 'phaka/*'
    }
    agent {
        label "packer"
    }
    triggers {
      pollSCM 'H/5 * * * *'
    }
    environment {
        // Credentials to access vCenter
        PKR_VAR_vcenter_username = credentials('packer-vcenter-username')
        PKR_VAR_vcenter_password = credentials('packer-vcenter-password')
        PKR_VAR_vcenter_server = credentials('packer-vcenter-server')

        // Credentials to access vSphere
        PKR_VAR_vsphere_host = credentials('packer-vsphere-host')
        PKR_VAR_vsphere_network = credentials('packer-vsphere-network')
        PKR_VAR_vsphere_datastore = credentials('packer-vsphere-datastore')

        // Credentials to access the virtual machine once installed
        PKR_VAR_ssh_password = credentials('packer-ssh-password')
        PKR_VAR_ssh_password_hashed = credentials('packer-ssh-password-hashed')
        //PKR_VAR_ssh__authorized_key = credentials('packer-ssh-authorized-key')

        // Credentials of the user to create to specialize the virtual machine afterwards
        PKR_VAR_packer_username = credentials('packer-username')
        PKR_VAR_packer_password = credentials('packer-password')
        PKR_VAR_packer_password_hashed = credentials('packer-password-hashed')
        //PKR_VAR_packer_authorized_key = credentials('packer-authorized-key')

        // The server where we can access the ISOs. This can be a local path to the vSphere server or a remote URL.
        PKR_VAR_iso_path_prefix = credentials('debian-mirror')
    }
    stages {
        stage('Build') {
            steps {
                sh 'packer init .'
                sh 'packer validate .'
                sh 'packer build -color=false -timestamp-ui .'
            }
        }
    }
    post {
        success {
            archiveArtifacts artifacts: 'manifest.json', fingerprint: true
        }
    }
}

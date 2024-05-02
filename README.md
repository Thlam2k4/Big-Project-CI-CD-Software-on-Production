# Big-Project-CI-CD-Software-on-Production

<img align = "center" alt = "coding" width = "400" src = "https://res.cloudinary.com/dtbudl0yx/image/fetch/w_2000,f_auto,q_auto,c_fit/https://adamtheautomator.com/content/images/size/w2000/2019/12/jenkins-powershell.png">


-----WorkFlow of Project---------

<img align = "center" alt = "coding" width = "600" src = "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjo12kzpGxAUXGK93c_6xvDY5jGHfugEyklNfk4hSkOG-k0VLbpyUn12T1_hLb_6ULHrvc9c6lyfruKLttlEFsWj1kXemLeZf9z2Oz7xFs-WfDg3D8XHW4Dw2tnSYpNxn_BrXRxPUYf_b5Hu6pkydY2k72XgW5F9lMOxhYdAwXy9O60IucVfkoV87q-Mw-P/s981/jenkins_workflow.png"> 


*Start -> Git Checkouting and Pulling code -> Testing -> Build Docker image and push to DockerHub -> Deploy to Production in Kubernetes -> Testing in Production.

*Component of project:

    - 1 Jenkins server run on AWS cloud for Continuous Intergration &&  Continuous Deployment.

    - 1 Kubernetes Cluster on your local Machine: 

        + 1 Master-Node: master.xtl run on IP 172.16.10.100.

        + 1 Worker-Node: worker1.xtl run on IP 172.16.10.101.

    - 1 Nodejs application with function login with user and password are storaged at MYSQL database.


------Prequisites Software-------

1.Terraform

2.Docker

3.AWS Configure(IAM role)

4.Node

------Tutorials------------------

    Step 1: Initialize 2 Virtual Machine run Kubernetes Cluster.
        
        + Change Directory to vm, in the file master-node and worker1-node you run the commands:

                        vagrant up

    Step 2(Update): Create Kuberenets Cluster 

        + Since the k8s use containerd to its default container runtime,So you need to remove docker and 

          install containerd to use kubeadm command in the file script/installcontainerd.txt
        
        + SSH to master.xtl and worker1.xtl (with -username root -password 123) and in

        Master node run this command to create K8s Cluster.

                sudo kubeadm init --pod-network-cidr=192.168.0.0/16

                mkdir -p $HOME/.kube

                sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

                sudo chown $(id -u):$(id -g) $HOME/.kube/config
        
                export KUBECONFIG=/etc/kubernetes/kubelet.conf
        
        + You need to install network Plugin in https://kubernetes.io/docs/concepts/cluster-administration/addons/

                kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.3/manifests/tigera-operator.yaml


                kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.3/manifests/custom-resources.yaml

        + Connect Worker Node to Master Node:

            In MasterNode run this command:  kubeadm token create --print-join-command

            In WorkerNode copy this output of above command:

        
    =>> Use: kubectl get nodes to get cluster created successfully!!!!

<img align = "center" alt = "coding" width = "600" src = "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj2Y-IoUaAzoDNXQayej0xc5TWMOyehyI-Grz5SKuNJdwihnenDFE86xFzxGKhpbxoVpNqFNmCy0TtHE-02CypGsy6DaNr6PGV6rEt1ikBJOnUnIDSuIGJtulaxBQbn5OiRVzB1ySK00-IOIkd5gO_w5umW8BEfn6zPCoq-ih8stgVkgng3YjfOjQY6ODZf/s965/virtual_machine.png">


    Step 3: Config the Jenkins server in AWS.

        + Change Directory to Ec2-instance and run this command.

                        terraform init
        
                        terraform plan

                        terraform apply
        
        >In the AWS console you can see your EC2 instance with jenkins run in Docker(Ec2 instance already installed docker and run Jenkins in port 8080).

        + You have the public IP of Ec2 instance, you can reach your app in  <public-aws-ip>:8080.

        The image of pages:

<img align = "center" alt = "coding" width = "400" src = "https://benmatselby.dev/img/jenkins-login-admin.png">

        + After Login you need to install some plugin(KuberenetsContinousDeploy,Docker,Blueocean).

        + You create a new item with Pipeline Project and you use Pipeline script with SCM option.

        *Note: You need to write some credentials like (docker registry, kubeconfigid).

        +Before you run this job you must check your K8s cluster is active in step 2?

        >>You can run and you can see the project successfully.

<img align = "center" alt = "coding" width = "600" src = "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjo12kzpGxAUXGK93c_6xvDY5jGHfugEyklNfk4hSkOG-k0VLbpyUn12T1_hLb_6ULHrvc9c6lyfruKLttlEFsWj1kXemLeZf9z2Oz7xFs-WfDg3D8XHW4Dw2tnSYpNxn_BrXRxPUYf_b5Hu6pkydY2k72XgW5F9lMOxhYdAwXy9O60IucVfkoV87q-Mw-P/s981/jenkins_workflow.png"> 



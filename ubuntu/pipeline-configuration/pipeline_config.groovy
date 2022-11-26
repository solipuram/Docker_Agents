libraries{
   git
   {
      url = "git url"
      credentialsId = "ci_demo_id"
      branch = "devops"
   }
   harbor{
      login{
             credentialsId ="harbor_jte"
          
      }
      image{
         name = "file-beat"
         dir = "."
         
      }
      registry{
         url_prod = "repository url"
         url_dev= "repository url"
         repository_prod = "repository name"
         repository_dev = "repository name"
      }

   }
} 
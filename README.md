# Euro-mediterranean Centre on Climate Change Foundation 
## Job Call 12724 - 2 Cloud System Administrators Junior and/or Senior
### Name: Emmanuel Okose
### First Interview: 17/07/2025
### Invitation date: 26/08/2025 at 10:00 
### Due Date: 02/09/2025 at 10:00
### Exercise: Helm Chart for Deploying JupyterHub with Dual PVCs
### Objective:
#### Create a Helm Chart that deploys a JupyterHub* instance along with two associated PersistentVolumeClaims (PVCs) of different sizes. One PVC should be configured as read-only and used for processing input data, while the other should be read-write for storing “jupyter notebooks” and results.
[*] https://jupyter.org/
### Requirements:
#### JupyterLab Deployment:
- Package a JupyterHub instance in a Kubernetes Deployment.
- Allow configuration of basic settings (e.g., replica count, container image tag) via the _values.yaml_ file.
#### PersistentVolumeClaims:
##### Data Volume:
- Create a PVC intended for input data processing.
- Configure it with a smaller size (e.g., 5Gi) and mount it as read-only.
#### Notebook Volume:
- Create a PVC intended for notebooks and output storage.
- Configure it with a larger size (e.g., 20Gi) and allow read-write access.
- Both PVC sizes and mount paths should be configurable from the _values.yaml_.
- Authentication: Provide basic authentication based on Dummy Authenticator
- Helm Templating Best Practices:
- Use parameterized templates to support configuration via _values.yaml_.
- Include proper labels, annotations, and naming conventions.
- Make sure to manage any potential template errors gracefully (e.g., missing parameters).
#### Documentation:
##### Provide a clear and concise README explaining:
- How to install, upgrade, and uninstall the chart.
- How to customize the PVC sizes, mount paths, and any other configurable parameters.
##### Optional Enhancements:
- Security: Consider implementing a securityContext in the pod spec (e.g., running as non-root).
- Ingress/Service Exposure: Optionally add an Ingress or Service configuration to expose JupyterHub externally.
- Readiness/Liveness: Optionally add readiness/liveness checks in order to enhance the reliability and stability of the application.
##### Authentication Mechanism:
- Enhance the authentication method, by taking advantage of external identity provider or OAuth service (e.g. Github/Google Login)
- Testing: Include Helm test hooks or instructions for validating the installation (e.g., using helm lint and helm test).
#### Evaluation Criteria:
##### Functionality:
- The Helm Chart successfully deploys JupyterHub.
- Both PVCs are created with the specified configurations: one read-only for input data and one read-write for writing notebooks.
#### Configurability:
- Key parameters (e.g., PVC sizes, mount paths, image tags) are exposed in values.yaml for easy customization.
#### Code Quality:
- The chart follows Helm best practices with clear templating, proper structure, and appropriate use of labels and annotations.
#### Documentation:
- The README provides clear, concise instructions on chart usage and customization.
#### Additional Suggestions:
#### Resource Management:
- Consider adding resource requests and limits to the JupyterHub container for better cluster resource management.
#### Custom Environment Variables:
- Allow passing custom environment variables (e.g., for configuring JupyterLab settings) via the Helm chart.
#### Lifecycle Hooks:
- Optionally include pre-install or post-install hooks for initial setup or data preloading tasks.
##### This exercise is designed to test the candidate's practical skills with Kubernetes, Helm templating, and handling stateful applications in a cloud environment. It also evaluates their ability to write clear documentation and manage configurable parameters.

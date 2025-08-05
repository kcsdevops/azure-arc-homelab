# Copilot Instructions for Azure Arc HomeLab

<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

## Project Context

This is an Azure Arc HomeLab project repository focused on enabling on-premises servers to be managed through Azure. The project includes:

- PowerShell scripts for Windows servers
- Bash scripts for Linux distributions  
- Azure Resource Manager templates
- Azure Policy definitions
- Monitoring configurations
- Comprehensive documentation in Portuguese

## Coding Standards

### PowerShell Scripts
- Use approved verbs and PascalCase for functions
- Include comprehensive error handling with try/catch blocks
- Use `Write-Log` function for consistent logging
- Support Windows Server 2019+ and Windows 10/11
- Include parameter validation and help documentation
- Use Azure PowerShell modules when interacting with Azure

### Bash Scripts  
- Follow POSIX standards when possible
- Use the `log()` function for consistent messaging
- Include distribution detection for Ubuntu, CentOS/RHEL, SUSE
- Use shellcheck for script validation
- Include proper error codes and exit conditions
- Support major Linux distributions used in HomeLab environments

### Azure Resources
- Use ARM templates or Bicep for infrastructure as code
- Follow Azure naming conventions and resource tagging
- Implement least privilege access principles
- Include monitoring and alerting configurations
- Use Azure Resource Graph queries for resource management

### Documentation
- Write primarily in Portuguese (Brazilian)
- Use markdown with proper formatting
- Include practical examples and code snippets
- Maintain consistency with existing documentation style
- Update README.md when adding new features

## Security Guidelines

- Never include hardcoded secrets, API keys, or credentials
- Use Azure Key Vault references for sensitive data
- Implement proper RBAC for Azure resources
- Follow Azure Security Baseline recommendations
- Include security considerations in documentation

## Azure Arc Specific

- Focus on hybrid cloud scenarios
- Support multiple operating systems
- Include connectivity options (public, proxy, private endpoint)
- Consider Azure Policy compliance requirements
- Implement proper tagging and resource organization
- Support Azure Monitor and Log Analytics integration

## Testing Considerations

- Test scripts on actual HomeLab environments when possible
- Support common HomeLab scenarios (limited resources, home networks)
- Include validation steps and troubleshooting guides
- Consider offline installation scenarios
- Test with various Azure subscription types

When generating code or documentation, prioritize practical HomeLab use cases and ensure compatibility with typical home lab infrastructure constraints.

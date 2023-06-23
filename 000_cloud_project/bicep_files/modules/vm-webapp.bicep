/* -------------------------------------------------------------------------- */
/*                     Virtual Machine / Server                               */
/* -------------------------------------------------------------------------- */
// managementVirtualMachine: Finally, the management virtual machine resource is defined. It depends on 
// the managementNetworkInterface because it requires a network interface to be associated with the virtual 
// machine. By placing the virtual machine definition last, we ensure that all the necessary dependencies, 
// such as the network interface, NSG, and subnet, are created and available.

// ToDo: Management server is a WINDOWS SERVER
// ToDo: Web server is a a LINUX SERVER
// ToDo: Make a key vault first for the 'All VM disks must be encrypted.'
// ToDo: Connect Availability Set resource
// resource VMManagement 'Microsoft.Compute/virtualMachines@2023-03-01' = {
//   name: 
//   location: 
// }

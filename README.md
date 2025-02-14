**scourge** 

The sysops framework used by antif4.com 

Command line tools for the creation and management of: 
* VPS instances
* software installations/updates
* basic administrative tasks

Early days.

How scourge sees the world: 

* scourge only cares about hosts, servers, and software.
* Hosts produce servers. Servers run software. 
* A host is anything that can run Ubuntu and provide an ssh connection. 
* Software is anything that can be installed and managed via ssh.

All three entities can be: 
* CRUD
* List/search
* checks
  * status
  * deep
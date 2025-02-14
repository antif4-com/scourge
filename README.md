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

scourge believes it can eat the world through flexibility and managing the world at this level of abstraction. No fancy all-in-one wonder boxes! 

All three entities can be: 
* CRUD
* List/search
* checks
  * status
  * deep


Principles:
* State-less.
  * Where required, config is only local txt files. 
  * 

Hero workflow (starting from _as minimum as possible_):
  * copy keys/config from backup (not scourge's responsibility)
  * gem install scourge
  * scourge:sys:restore

And I do mean minimum. Minimal local config. A few text files, ssh, ruby, and access to gems. Then bam, you can get your whole system back up to prior state. 

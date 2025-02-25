# **scourge** 

Command line tools for the creation and management of: 
* servers (ssh endpoints)
* software 
* administrative tasks

Scourge endevors to be delightful to the humans who must come in contact with it, through using it directly or extended it to support additional . 

Think Thor + rails scaffolding + cPanel. But cooler?

Early days.

And by "early days", I mean, everything written here is almost certainly wrong and subject to change. I know so little about so much. Keep reading to understand just how little.  

### What is scourge?

Scourge sees itself as a very high-level compute management platform. Most of you probably wondered what a "very high-level compute management platform" is. Great question. But how many of you asked "How did Scourge observe itself to make this observation"? Regardless, scourge's role is to act as an abstraction layer make managing a network topology of network services with as minimal human interaction as possible. CLI commands go into scourge, and scourge creates and controls a network topology. But the network topology is simple in complexity. No fanciness.

I have a lot of motivations for this approach. Unlike platforms like k8s, scourge not use purpose built technologies. I'm not sure exactly how to explain this clearly yet, but much of the power of the early internet, and even the internet of today, relied(s) on its de-centralized, standards based federation of  services. As we have become more hyper optimized towards different compute paradigm and hosting providers in search for ever diminishing returns within scale. Our modern compute infrastracture has become pradoxically more powerful, brittle, and under centralized control. 

This centralized control, primarily in the hands of large US corporations, is not good for you, and it's not good for me. To try and combat this, scourge will provide high-enough levels of resiliency across simple network topologies. 

If I want to wax poetic and shoot for the stars, I want scourge to make managing a simple network topology feel as simple, yet powerful as Ruby on Rails did for web dev. The tool selection and overall architecture is heavily inspired from Ruby/Rails and scourge plays an Ansible-like role. 

### What is a simple network topology?

I don't know. However, I expect that I will always define it in terms of what scourge is not currently capable of covering. While I want scourge to be re-usable and will do quite a bit of work to keep it that way, at it's core, scourge is a tool I am writing to help me manage my own networks. This means, untill there is sufficient demand for scourge as a standalone deliverable, I will craft its capabilities with an eye towards my own personal requirements. My personal network topology has a series of web, mail, and related support services that it will manage. This will be the first focus for scourge. 

I'm not sure if this is the correct stance to take and am open to feedback. 

### You like, got any principles or something?

Principles:
* State-less.
  * Where required, config is only local txt files or what can be regenerated using ruby.
* Not Sexy. 
  * Look, we all find our own beauty. But scourge isn't sexy. It uses the lamest, simpliest, old as dirt technologies to accomplish its end. If it's shiny, new, fancy, and some VC tech bro's eyebrow hair raises? scourge will run away from it. 
* Federation via established standards or die.
  * No centralization or vendor-specific wonder "app in a box".  
* Heterogeneous compute layer
  * scourge should be fully operational across a diverse and constantly changing hosting/server configuration
  * the software is what is important, everything underneath can change constantly

Hero workflow (starting from _as minimum as possible_):
  * copy keys/config from backup (not scourge's responsibility)
  * `gem install scourge`
  * `scourge sys:restore`

And I do mean minimum. Minimal local config. A few text files, ssh, ruby, and access to gems. Then bam, you can get your whole system back up to prior state.

### Ok, enough idealistic crap, what is it actually?

How scourge sees the world: 

* A per host implimentation of ServerFactory creates and manages Server objects.
* A Software object can install and manage itself on a Server. 
* Server objects are the glue between compute running on a host and software installed.
  * Server objects encapsulate an ssh endpoint
  * Server objects are not host or Software specific.

scourge believes it can eat the world through flexibility and managing the world at this level of abstraction. nomnomnom. No fancy all-in-one wonder boxes! 

### Architecture

![source_highlevel](https://github.com/user-attachments/assets/e3a21c4b-4d95-4829-8476-ac2d02cc7b4e)
Hehe, kind of? This is currently what's in my head. I wouldn't even say the full skeleton is in the code yet. 

* tty-based GUI/CLI over
* Thor-based commands
* to manage
  * Host objects
  * Server objects
  * Software objects
* via a Manifold object
  * The manifold object is the object responsible for serializing the core YAML config
  * I believe the Manifold object is the correct place to store "network utility" functionality as well.  
* extended via code generators to create new
  * Host ServerFactory implimentations
  * Software Object implimentations
  * whatever the "network utility" thing is

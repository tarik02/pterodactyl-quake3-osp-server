
![Quake 3 Arena OSP in Docker](https://raw.githubusercontent.com/wokoman/docker-quake3-osp-server/master/q3aospdockerlogo.png)


Running this image starts Quake 3 Arena server with OSP and instagib on. Using full **OSP 1.03a**.

#### Requirements
This image is fully functional, you only need to supply your own `pak0.pk3` file.

Running the image is then simple as:

```
docker run --name q3aospserver -d -p 27960:27960/udp -v /path/to/pak0.pk3:/usr/share/games/quake3/baseq3/pak0.pk3 michalkozakgd/quake3-osp-server
```

#### Customization
If you want to run the server with OSP, but with your own settings, you can either feed the commands through Docker CLI as in:

```
docker run --name q3aospserver -d -p 27960:27960/udp -v /path/to/pak0.pk3:/usr/share/games/quake3/baseq3/pak0.pk3 michalkozakgd/quake3-osp-server +fraglimit 150
```

Or entire server config:

```
docker run --name q3aospserver -d -p 27960:27960/udp -v /path/to/pak0.pk3:/usr/share/games/quake3/baseq3/pak0.pk3 -v /path/to/server.cfg:/usr/share/games/quake3/osp/server.cfg michalkozakgd/quake3-osp-server
```

Or even better, there's a example of `docker-compose.yml` file in the repo, which you can freely customize. Simply amend `command` line to your liking, or supply your own `server.cfg` altogether.

#### Defaults
Rcon password is set to `kolikchcesparku`. You can set your own within game with `;rcon seta rconpassword "<secretpassword>"`.

Default config starts arena with fraglimit 30 on q3dm17 with instagib on. You're free to use any included OSP gamemode by `;rcon exec <config>.cfg`.

#### Troubleshooting
The server logs, so you can simply:

```
docker logs q3aosperver
```

#### Shoutouts
I forked this image from [InAmiTe](https://github.com/InAnimaTe/docker-quake3) who took [jberrenberg](https://hub.docker.com/r/jberrenberg/quake3) image in the first place. Shoutout!

I also wanted to thank the Debian Games Team for [this](https://packages.debian.org/stable/games/quake3-server) excellent package.

#### Quake 3 Arena server how-tos

Here are some really helpful links for setting up the `server.cfg` and utilizing rcon. 

* [http://www.joz3d.net/html/q3console.html](http://www.joz3d.net/html/q3console.html)
* [http://it.rcmd.org/networks/q3_install/q3_linux_server_howto.php#step9](http://it.rcmd.org/networks/q3_install/q3_linux_server_howto.php#step9)
* [http://www.tldp.org/HOWTO/archived/Game-Server-HOWTO/quake3.html](http://www.tldp.org/HOWTO/archived/Game-Server-HOWTO/quake3.html)
* [http://gaming.stackexchange.com/questions/46735/quake-3-private-server-with-bots](http://gaming.stackexchange.com/questions/46735/quake-3-private-server-with-bots)
* [http://notes.splitbrain.org/q3aserver](http://notes.splitbrain.org/q3aserver)
* [http://www.katsbits.com/articles/quake-3/add-remove-bots.php](http://www.katsbits.com/articles/quake-3/add-remove-bots.php)
* [http://www.3dgw.com/guides/q3a/index.php3?page=configs.htm#serverbots](http://www.3dgw.com/guides/q3a/index.php3?page=configs.htm#serverbots)

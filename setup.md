# setup.md

To allow the org.gnu.emacs flatpak package access to the ssh-auth socket.

```
flatpak override --user \
    --share=network \
    --socket=ssh-auth \
    --socket=gpg-agent \
    org.gnu.emacs
```

Then, add to `~/.gnupg/gpg-agent.conf`:

```
enable-ssh-support
pinentry-program /usr/bin/pinentry
```
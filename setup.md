# setup.md

To allow the org.gnu.emacs flatpak package access to the ssh-auth socket.

```
flatpak override --user \
    --share=network \
    --socket=ssh-auth \
    org.gnu.emacs
```

BeeBaby
=======

INSTALL
____________

To install run the command bellow:

```bash
BeeBaby> sudo sh install
```

Fix the permissions with the following command

```bash
BeeBaby> sudo chown -R {your_user} {path_to_beebaby_folder}
```

After install open the project with `BeeBaby.xcworkspace` and not `BeeBaby.xcodeproj`

LIBRARIES
_____________

Add libraries by adding a pod into the Podfile and running `pod install`

- AFNetworking
  Used for service calls
- Kiwi
  Testing
- ReactiveCocoa
  Lists and Stream manipulation
- NewRelicAgent
  Metrics using NewRelic

TESTING
__________

Write tests specs as in ViewControllerSpec.m

ps: "there is a Kiwi template file that helps creating a new spec" - http://markstruzinski.com/blog/2012/08/18/xcode-file-template-for-kiwi-tests/

CONTINOUS INTEGRATION
___________

Install command line tools:

Run `gcc` on the terminal, the OS will prompt for the commandline tools download.

Install brew:

```
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
```

Install xctool:

```bash
brew install xctool
```

Run `ci.sh` on the CI server.

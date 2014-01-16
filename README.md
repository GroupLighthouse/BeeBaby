BeeBaby
=======

INSTALL
____________

To install run the command bellow:

```bash
BeeBaby> sudo sh install
```

Fix the permissions with the following command

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

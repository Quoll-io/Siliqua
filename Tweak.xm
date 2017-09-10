// Siliqua Source. Created by LaughingQuoll. Copyright 2017.
// Special Thanks to finngaida for adding quad tap action ability.

// Collect our headers. We don't need many.

#import "MediaRemote.h"
#import "NSTimer+Blocks.h"

@interface NSTimer (Private){

}
+ (id)scheduledTimerWithTimeInterval:(double)arg1 invocation:(id)arg2 repeats:(BOOL)arg3;
+ (id)scheduledTimerWithTimeInterval:(double)arg1 repeats:(BOOL)arg2 block:(id /* block */)arg3;
+ (id)scheduledTimerWithTimeInterval:(double)arg1 target:(id)arg2 selector:(SEL)arg3 userInfo:(id)arg4 repeats:(BOOL)arg5;
@end
@interface BluetoothDevice
- (unsigned int)doubleTapAction;
- (bool)setDoubleTapAction:(unsigned int)arg;
-(BOOL)magicPaired;
@end

@interface MPMusicPlayerController
+ (id)systemMusicPlayer;
- (void)play;
- (void)skipToNextItem;
@end

@interface SBHomeScreenViewController
- (BOOL)justTapped;
- (void)setJustTapped:(BOOL)value;
@end

@interface SBMediaController : NSObject
+ (id)sharedInstance;
- (UIImage *)artwork;
- (BOOL)isPlaying;
- (BOOL)play;
- (BOOL)Pause;
- (BOOL)hasTrack;
- (BOOL)_sendMediaCommand:(unsigned)command;
- (BOOL)skipFifteenSeconds:(int)seconds;
-(void)increaseVolume;
-(void)decreaseVolume;
-(BOOL)_sendMediaCommand:(unsigned)arg1 ;
-(void)_changeVolumeBy:(float)arg1 ;
@end

bool Enabled;
bool dtPausePlay;
bool dtSkip;
bool dtRewind;
bool dtSkip15;
bool dtRewind15;
bool dtIncreaseVolume;
bool dtDecreaseVolume;
bool dtToggleSiri;

bool qtPausePlay;
bool qtSkip;
bool qtRewind;
bool qtSkip15;
bool qtRewind15;
bool qtIncreaseVolume;
bool qtDecreaseVolume;
bool qtToggleSiri;

@interface SBAssistantController
+ (id)sharedInstance;
- (void)handleSiriButtonUpEventFromSource:(int)arg1;
- (_Bool)handleSiriButtonDownEventFromSource:(int)arg1 activationEvent:(int)arg2;
+(BOOL)isAssistantVisible;
-(long long)participantState;
-(void)dismissAssistantView:(long long)arg1 forAlertActivation:(id)arg2 ;
@end

static BOOL isShowingAss(){ //;)
    SBAssistantController *assistantController = [%c(SBAssistantController) sharedInstance];
    if ([%c(SBAssistantController) respondsToSelector:@selector(participantState)]){
        if ((int)[assistantController participantState] == 1)
            return NO;
        return YES;
    } else {
        if (![%c(SBAssistantController) isAssistantVisible])
            return NO;
        return YES;
    }
}

%hook SBHomeScreenViewController
// This hook will run our actions, whatever they are.
static BOOL justTapped = NO;
static NSTimer *timer;

- (void)viewDidLoad {
    %orig;
    // Register for our double tap notification.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recivedDoubleTapNotificationFromAirPods:) name:@"com.laughingquoll.runairpodsdoubletappedaction" object:nil];
}
%new
- (void)recivedDoubleTapNotificationFromAirPods:(NSNotification *)notification {
    // Firstly check that the notification is in fact the double tap action.
    if ([[notification name] isEqualToString:@"com.laughingquoll.runairpodsdoubletappedaction"]) {
        // Credits to Finn Gaida who created quad tap for me :P
        if (justTapped) {
            // quad tap action
            
            if(qtPausePlay){
                MRMediaRemoteSendCommand(kMRTogglePlayPause, 0);
            }
            
            if(qtSkip){
                MRMediaRemoteSendCommand(kMRNextTrack, 0);
            }
            
            if(qtRewind){
                MRMediaRemoteSendCommand(kMRPreviousTrack, 0);
            }
            
            if(qtSkip15){
                // Both don't seem to work, looking for alternatives?
                // [[%c(SBMediaController) sharedInstance] skipFifteenSeconds:+15];
                // MRMediaRemoteSendCommand(kMRSkipFifteenSeconds, 0);
                [[%c(SBMediaController) sharedInstance] _sendMediaCommand:17];
            }
            
            if(qtRewind15){
                // Both don't seem to work, looking for alternatives?
                // [[%c(SBMediaController) sharedInstance] skipFifteenSeconds:-15];
                // MRMediaRemoteSendCommand(kMRGoBackFifteenSeconds, 0);
                [[%c(SBMediaController) sharedInstance] _sendMediaCommand:18];
            }
            
            if(qtIncreaseVolume){
                [[%c(SBMediaController) sharedInstance] _changeVolumeBy:0.1];
            }
            
            if(qtDecreaseVolume){
                [[%c(SBMediaController) sharedInstance] _changeVolumeBy:-0.1];
            }
            
            if(qtToggleSiri){
                SBAssistantController *assistantController = [%c(SBAssistantController) sharedInstance];
                if(!isShowingAss()){
                    [assistantController handleSiriButtonDownEventFromSource:1 activationEvent:1];
                    [assistantController handleSiriButtonUpEventFromSource:1];
                } else {
                    [assistantController dismissAssistantView:1 forAlertActivation:nil];
                }
            }
            
            [timer invalidate];
            justTapped = NO;
        } else {
            justTapped = YES;
            timer = [NSTimer scheduledTimerWithTimeInterval:0.6 block:^{
                
                if(dtPausePlay){
                    MRMediaRemoteSendCommand(kMRTogglePlayPause, 0);
                }
                
                if(dtSkip){
                    MRMediaRemoteSendCommand(kMRNextTrack, 0);
                }
                
                if(dtRewind){
                    MRMediaRemoteSendCommand(kMRPreviousTrack, 0);
                }
                
                if(dtSkip15){
                    // Both don't seem to work, looking for alternatives?
                    // [[%c(SBMediaController) sharedInstance] skipFifteenSeconds:+15];
                    // MRMediaRemoteSendCommand(kMRSkipFifteenSeconds, 0);
                    [[%c(SBMediaController) sharedInstance] _sendMediaCommand:17];
                }
                
                if(dtRewind15){
                    // Both don't seem to work, looking for alternatives?
                    // [[%c(SBMediaController) sharedInstance] skipFifteenSeconds:-15];
                    // MRMediaRemoteSendCommand(kMRGoBackFifteenSeconds, 0);
                    [[%c(SBMediaController) sharedInstance] _sendMediaCommand:18];
                }
                
                if(dtIncreaseVolume){
                    [[%c(SBMediaController) sharedInstance] _changeVolumeBy:0.1];
                }
                
                if(dtDecreaseVolume){
                    [[%c(SBMediaController) sharedInstance] _changeVolumeBy:-0.1];
                }
                
                if(dtToggleSiri){
                    
                    SBAssistantController *assistantController = [%c(SBAssistantController) sharedInstance];
                    if(!isShowingAss()){
                        [assistantController handleSiriButtonDownEventFromSource:1 activationEvent:1];
                        [assistantController handleSiriButtonUpEventFromSource:1];
                    } else {
                        [assistantController dismissAssistantView:1 forAlertActivation:nil];
                    }
                }
                
                justTapped = NO;
            } repeats:NO];
        }
    }
}

%end

%hook BluetoothManager
// This method is called for a multitude of purposes and we can get alot out of it.
// It is called every double tap on the AirPods with the two strings in the array. That way we can tell it was infact a double tap.
// By preventing %orig when the strings are present then we effectivly cut siri off.
- (void)_postNotificationWithArray:(id)arg1 {
  %log;
  //BluetoothDevice *device = [[NSClassFromString(@"BluetoothDevice") alloc] init];
  //if([device isAppleAudioDevice]){

    // This if statment could be just a if:elseif:else statement but that seemed to break it so the if:else:if:else will have to do.
    if(Enabled){
      NSString *stringOne = @"BluetoothHandsfreeInitiatedVoiceCommand";
      NSString *stringTwo = @"BluetoothHandsfreeEndedVoiceCommand";
      NSString *stringThree = @"BluetoothDeviceDisconnectSuccessNotification";
      // Check for the first string.
      if ( [arg1 containsObject:stringOne] ) {
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"com.laughingquoll.runairpodsdoubletappedaction"
             object:self];
      } else {
        // Check for the second string.
        if ( [arg1 containsObject:stringTwo] ) {
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"com.laughingquoll.runairpodsdoubletappedaction"
             object:self];
        // It wasn't any of the two strings so we just allow it to do whatever.
        } else {
            // Unfinished feature, add an action when AirPods become connected.
            if([arg1 containsObject:stringThree] ) {
              NSLog(@"AirPods just became connected");
            }
            return %orig;
        }
      }
    } else {
      %orig;
    }
  //} else {
  //  %orig;
  //}
}

%end

static void settingsChangedSiliqua(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
    @autoreleasepool {
        NSDictionary *SiliquaPrefs = [[[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.laughingquoll.siliquaprefs.plist"]?:[NSDictionary dictionary] copy];
        Enabled = (BOOL)[[SiliquaPrefs objectForKey:@"enabled"]?:@YES boolValue];

        // Our Double Tap Preferences
        dtPausePlay = (BOOL)[[SiliquaPrefs objectForKey:@"dtPausePlay"]?:@NO boolValue];
        dtSkip = (BOOL)[[SiliquaPrefs objectForKey:@"dtSkip"]?:@NO boolValue];
        dtRewind = (BOOL)[[SiliquaPrefs objectForKey:@"dtRewind"]?:@NO boolValue];
        dtSkip15 = (BOOL)[[SiliquaPrefs objectForKey:@"dtSkip15"]?:@NO boolValue];
        dtRewind15 = (BOOL)[[SiliquaPrefs objectForKey:@"dtRewind15"]?:@NO boolValue];
        dtIncreaseVolume = (BOOL)[[SiliquaPrefs objectForKey:@"dtIncreaseVolume"]?:@NO boolValue];
        dtDecreaseVolume = (BOOL)[[SiliquaPrefs objectForKey:@"dtDecreaseVolume"]?:@NO boolValue];
        dtToggleSiri = (BOOL)[[SiliquaPrefs objectForKey:@"dtToggleSiri"]?:@NO boolValue];

        // Our Quad Tap Preferences
        qtPausePlay = (BOOL)[[SiliquaPrefs objectForKey:@"qtPausePlay"]?:@NO boolValue];
        qtSkip = (BOOL)[[SiliquaPrefs objectForKey:@"qtSkip"]?:@NO boolValue];
        qtRewind = (BOOL)[[SiliquaPrefs objectForKey:@"qtRewind"]?:@NO boolValue];
        qtSkip15 = (BOOL)[[SiliquaPrefs objectForKey:@"qtSkip15"]?:@NO boolValue];
        qtRewind15 = (BOOL)[[SiliquaPrefs objectForKey:@"qtRewind15"]?:@NO boolValue];
        qtIncreaseVolume = (BOOL)[[SiliquaPrefs objectForKey:@"qtIncreaseVolume"]?:@NO boolValue];
        qtDecreaseVolume = (BOOL)[[SiliquaPrefs objectForKey:@"qtDecreaseVolume"]?:@NO boolValue];
        qtToggleSiri = (BOOL)[[SiliquaPrefs objectForKey:@"qtToggleSiri"]?:@NO boolValue];
    }
}
__attribute__((constructor)) static void initialize_Siliqua()
{
    @autoreleasepool {
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, settingsChangedSiliqua, CFSTR("com.laughingquoll.SiliquaPrefs/changed"), NULL, CFNotificationSuspensionBehaviorCoalesce);
        settingsChangedSiliqua(NULL, NULL, NULL, NULL, NULL);
    }
}

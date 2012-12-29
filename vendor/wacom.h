// Control actions for buttons, touch strips, etc. Not every control responds 
// to all these functions. 
//	      These enums are used by the cvotes class to determine what features will be
//	      available on different tablet types. See that class for more details.
#if !defined(ECommandType)

typedef enum _ECommandType

{

		ENone														     = 0,

		ELeftClick											       = 1,

		EMiddleClick									   = 2,

		ERightClick											      = 3,

		ELeftDoubleClick						    = 4,

		EMiddleDoubleClick					       = 5,

		ERightDoubleClick						  = 6,

		ELeftClickLock								       = 7,

		EKeystrokes											    = 8,

		EModifiers											      = 9,

		EPressureHold									 = 10,

		EModeToggle											  = 11,

		EMacro_Deprecated								= 12,			// played a QuicKeys macro on Mac OS 9

		EScreenMacro									 = 13,

		EAutoErase											     = 14,

		EBumbleFree											   = 15,

		EEraseKeystroke						     = 16,

		EEraseModifier								       = 17,

		EEraseMacro_Deprecated			= 18,			// played a QuicKeys macro on Mac OS 9

		EButton4Click									 = 19,

		EButton5Click									 = 20,

		EMiddleClickLock						   = 21,

		ERightClickLock						      = 22,

		ERunApplication						     = 23,

		EToggleInking									 = 24,

		ETabletPCTip									  = 25,

		ETabletPCEraser						      = 26,

		ETabletPCBarrel						      = 27,

		ETabletPCBarrel2						    = 28,

		EAppDefined											   = 29,

		ETPCInputPanel								      = 30,

		EDisplayToggle								       = 31,

		ETouchStripModifier					       = 32,

		EButtonPanning								       = 33,

		EButtonSetOverride				 = 34,

		EBack														      = 35,

		EForward												 = 36,

		EJournal												  = 37,

		EShowDesktop									= 38,

		ESwitchApp											     = 39,

		EHelp														      = 40,	//also known as Show Settings

		ERadialMenu											   = 41,

		EFinePoint											       = 42,

		ETouchToggle									 = 43,

		EAutoScrollZoom						    = 44,

		EScroll												     = 45,

		EZoom														    = 46,

		ESkip														       = 47,

		ERunBambooDock								  = 48,

		ERunBambooPreferences			= 49,

		EShowAllWindows						  = 50,			// Expose/Flip3D/Mission Control under 10.7

		ERotate												    = 51,

		EToggleOnScreenKeyboard		     = 52,

		EToggleControlPanel					       = 53,

		EShowAllAppWindows					   = 54,			//App Expos� under OSX 10.7

		EShowNextFullScreenApp		       = 55,			//Full screen app switching under 10.7

		EShowPreviousFullScreenApp		= 56,

		ELCDSettings									  = 57,			// not a real action, for help display string

		EShowDictionary						     = 58,

		EMetroDesktopToggle					     = 59,

 

		//Adding a new enumeration here? You'll also want to update the total count

		//and corresponding string values in DisplayStrings.cpp (if you don't, you'll get a compile error)

 

		EButtonTypeMax,												   // used to validate

		EButtonDefault									= 1000,    // Used by CPL to reset a button to default.

		EButtonRestoreBackup					    = 1001,    // 1001 Intentionally invalid

 

		EClicksGroup									  = 1010,    // view ID for Clicks submenu in ExpressKeys UI

		ETabletPCGroup								      = 1011,    // view ID for "Tablet PC" in ExpressKeys UI

 

		ESeparator											       = 0x7FFFFFFE	 // separator menu item

} ECommandType;

#endif // ECommandType

 

#if !defined(EModifiersType)

// Modifiers used in META_CHARs. These are *different* from the ones used by 

// SKeystroke. 

enum EModifiersType

{

		eNoModifier			    = 0x0000,

		eAlt							  = 0x0001,

		eControl				   = 0x0002,

		eShift				       = 0x0004,

		eOption				    = 0x0008,

		eCommand					      = 0x0010, // on PC this translates to VK_LWIN

		eClick				      = 0x0020,

		eLastInString	   = 0x0040,

		ePressed				  = 0x0080,

		eRightClick			      = 0x0100,

		eMiddleClick	   = 0x0200,

		eModifierMax	  = 0x0FFF,

		eUseSendInput	= 0xF000

};

#endif // EModifiersType

 

#if !defined(EDriverNotifications)

// the strings in here are not as mobile as one might like.

// as the value of the enum is tied to a specific string in

// the Mac 9/X driver.	       Make sure to add them in ascending order

// and don't move any of the old ones w/o careful consideration.

enum EDriverNotification

{

		EInvalidNotification = 0,

 

		ENoADBTabletAtBootNotification = 1,

		ENoSerialTabletNotification = 2,

		ENoADBTabletNotification = 3,

		EDriverDidNotLoadNotification = 4,

		ENoPortSelectedNotification = 5,

 

		ENoUSBTabletNotification = 6,

		ENoAvailableSerialNotification = 7,

		EDriverAbortedNotification = 8,

		EDriverInternalFailureNotification = 9,

		ESecondDriverFailureNotification = 10,

 

		ESystemVersionIncompatableNotification = 11,     

		ENewToolNotification_Depricated = 12, // EN-0087 rq.lf.dr

		EBatteryLowNotification = 13,

		ENeedCalibrationNotification = 14,

		EDisplayToggleNotification = 15,

 

		ENonMonetPenNotification = 16,

		EUserManualNotFound = 17,

		EAppMissingNotification = 18,

 

		EPrecisionModeWarning = 19,

 

		EMaxDriverNotificationPlusOne,

		EMaxDriverNotification = EMaxDriverNotificationPlusOne - 1

 

// 21 thru 35 are used for tablet menu strip

// 41 and up are also used

};

#endif

 

//	      I think we've opened Pandora's Box with these :->

#define RETURN_IF_NOT( comparison_I, status_I ) \

		do																													    \

		{																													      \

				WACSTATUS __status__ = status_I;						      \

				if ((__status__) != comparison_I)					   \

				{																											      \

						return (__status__);												 \

				}																											      \

		}																													      \

		while ( 0 )

 

#define    RETURN_IF_NOT_SUCCESS( status_I ) RETURN_IF_NOT( WACSTATUS_SUCCESS, status_I )

 

#define    RETURN_IF( comparison_I, status_I )   \

		do																											    \

		{																											      \

				WACSTATUS __status__ = status_I;				      \

				if ((__status__) == comparison_I)			   \

				{																									      \

						return __status__;										    \

				}																									      \

		}																											      \

		while ( 0 )

 

#define    RETURN_IF_SUCCESS( status_I ) RETURN_IF( WACSTATUS_SUCCESS, status_I )

 

#define RETURN_NOVAL_IF_NOT( comparison_I, status_I ) \

		do																													    \

		{																													      \

				WACSTATUS __status__ = status_I;						      \

				if ((__status__) != comparison_I)					   \

				{																											      \

						return;																				      \

				}																											      \

		}																													      \

		while ( 0 )

 

#define RETURN_NOVAL_IF_NOT_SUCCESS( status_I ) RETURN_NOVAL_IF_NOT( WACSTATUS_SUCCESS, status_I )

 

#define    ASSERT_IF_NOT( comparison_I, status_I, assertString )       \

		do																																			    \

		{																																			      \

				WACSTATUS __status__ = status_I;												      \

				if ((__status__) != comparison_I)											   \

				{																																	      \

						WACOM_ASSERT(!assertString);													   \

				}																																	      \

		}																																			      \

		while ( 0 )

 

#define    ASSERT_IF_NOT_SUCCESS( status_I, assertString ) ASSERT_IF_NOT( WACSTATUS_SUCCESS, status_I, assertString )

 

#define SIMPLE_ASSERT_IF_NOT( comparison_I, status_I )	       \

		do {																													 \

				WACSTATUS __status__ = status_I;								      \

				if (__status__ != comparison_I)									      \

				{																													      \

						WACOM_ASSERT(! #status_I );									     \

				}																													      \

		} while (0)

 

#define SIMPLE_ASSERT_IF_NOT_SUCCESS( status_I ) SIMPLE_ASSERT_IF_NOT( WACSTATUS_SUCCESS, status_I )

 

#define    ASSERT_THEN_RETURN_IF_NOT_SUCCESS( status_I, assertString )		\

		do																																											    \

		{																																											      \

				WACSTATUS __status__ = status_I;																				      \

				if ((__status__) != WACSTATUS_SUCCESS)																	 \

				{																																									      \

						WACOM_ASSERT(!assertString);																					   \

						return (__status__);																										 \

				}																																									      \

		}																																											      \

		while ( 0 )

 

#define    ASSERT_THEN_RETURN_FALSE_IF_NOT_SUCCESS( status_I, assertString )   \

		do																																											    \

		{																																											      \

				WACSTATUS __status__ = status_I;																				      \

				if ((__status__) != WACSTATUS_SUCCESS)																	 \

				{																																									      \

						WACOM_ASSERT(!assertString);																					   \

						return ( false );																													 \

				}																																									      \

		}																																											      \

		while ( 0 )

 

#define    ASSERT_AND_RETURN_NOVAL_IF_NOT_SUCCESS( status_I, assertString )   \

		do																																											    \

		{																																											      \

				WACSTATUS __status__ = status_I;																				      \

				if ((__status__) != WACSTATUS_SUCCESS)																	 \

				{																																									      \

						WACOM_ASSERT(!assertString);																					   \

						return;																																		      \

				}																																									      \

		}																																											      \

		while ( 0 )

 

#define RETURN_NOVAL_IF_NULL( memoryPointer )															\

		do																																											    \

		{																																											      \

				if ( ! memoryPointer )																											      \

				{																																									      \

						return;																																		      \

				}																																									      \

		}																																											      \

		while ( 0 )

 

#define    ASSERT_DELETE_RETURN_IF_NOT_SUCCESS( status_I, object, assertString ) \

		do																																													    \

		{																																													      \

				WACSTATUS __status__ = status_I;																						      \

				if ((__status__) != WACSTATUS_SUCCESS)																			 \

				{																																											      \

						WACOM_ASSERT(!assertString);																							   \

						delete object;																																	    \

						object = NULL;																																	\

						return (__status__);																												 \

				}																																											      \

		}																																													      \

		while ( 0 )

 

#define    ASSERT_DELETE_RETURN_NOVAL_IF_NOT_SUCCESS( status_I, object, assertString ) \

		do																																													    \

		{																																													      \

				WACSTATUS __status__ = status_I;																						      \

				if ((__status__) != WACSTATUS_SUCCESS)																			 \

				{																																											      \

						WACOM_ASSERT(!assertString);																							   \

						delete object;																																	    \

						object = NULL;																																	\

						return;																																				      \

				}																																											      \

		}																																													      \

		while ( 0 )

 

#define    ASSERT_THEN_RETURN_MEMORY_ALLOC_IF_NULL( memoryPointer, assertString ) \

		do																																													    \

		{																																													      \

				if (!memoryPointer)																														 \

				{																																											      \

						WACOM_ASSERT(!assertString);																							   \

						return WACSTATUS_MEMORY_ALLOC;																					     \

				}																																											      \

		}																																													      \

		while ( 0 )

 

#define ASSERT_AND_RETURN_IF_NOT_GET( pEvent, assertString )							       \

		do																																													    \

		{																																													      \

				if ((pEvent)->Command() != ECommandGet)																	 \

				{																																											      \

						WACOM_ASSERT(!assertString);																							   \

						return (pEvent)->SetStatus(WACSTATUS_METHOD_NOT_IMPLEMENTED).Status(); \

				}																																											      \

		}																																													      \

		while ( 0 )

 

#define SET_EVENT_STATUS_AND_RETURN_IF_NOT_SUCCESS( pEvent, status_I, assertString ) \

		do																																													    \

		{																																													      \

				WACSTATUS __status__ = status_I;																						      \

				if ((__status__) != WACSTATUS_SUCCESS)																			 \

				{																																											      \

						WACOM_ASSERT(!assertString);																							   \

						return (pEvent)->SetStatus(__status__).Status();								     \

				}																																											      \

		}																																													      \

		while ( 0 )

 

#define ASSERT_AND_RETURN_NOVAL_IF_NULL( memoryPointer, assertString )	  \

		do																																													    \

		{																																													      \

				if ( !memoryPointer )																													       \

				{																																											      \

						WACOM_ASSERT( !assertString );																					 \

						return;																																				      \

				}																																											      \

		}																																													      \

		while ( 0 )

 

#define ASSERT_AND_RETURN_IF_NULL( memoryPointer, assertString )					 \

		do																																													    \

		{																																													      \

				if ( !memoryPointer )																													       \

				{																																											      \

						WACOM_ASSERT( !assertString );																					 \

						return NULL;																																	   \

				}																																											      \

		}																																													      \

		while ( 0 )

 

#define ASSERT_AND_CONTINUE_IF_NULL( memoryPointer, assertString )		     \

		{																																													      \

				if ( !memoryPointer )																													       \

				{																																											      \

						WACOM_ASSERT( !assertString );																					 \

						continue;																																		  \

				}																																											      \

		}																																													      \

 

#define ASSERT_AND_RETURN_STATUS_IF_NULL( memoryPointer_I, status_I, assertString_I ) \

		do																																													    \

		{																																													      \

				if ( !memoryPointer_I )																													   \

				{																																											      \

						WACOM_ASSERT( !assertString_I );																				      \

						return status_I;																															\

				}																																											      \

		}																																													      \

		while ( 0 )

 

#define ASSERT_AND_RETURN_NOVAL_IF_FALSE( condition_I, assertString_I ) \

		do																																													    \

		{																																													      \

				if ( !(condition_I) )																												  \

				{																																											      \

						WACOM_ASSERT( !assertString_I );																				      \

						return;																																				      \

				}																																											      \

		}																																													      \

		while ( 0 )

 

 

#define ASSERT_AND_RETURN_FALSE_IF_FALSE( condition_I, assertString_I ) \

		do																																													    \

		{																																													      \

				if ( !(condition_I) )																												  \

				{																																											      \

						WACOM_ASSERT( !assertString_I );																				      \

						return false;																																	     \

				}																																											      \

		}																																													      \

		while ( 0 )

 

#define ASSERT_AND_RETURN_STATUS_IF_FALSE( condition_I, status_I, assertString_I ) \

		do																																													    \

		{																																													      \

				if ( !(condition_I) )																												  \

				{																																											      \

						WACOM_ASSERT( !assertString_I );																				      \

						return status_I;																															\

				}																																											      \

		}																																													      \

		while ( 0 )

 

#define ASSERT_AND_RETURN_NULL_IF_FALSE( condition_I, assertString_I ) \

		do																																													    \

		{																																													      \

				if ( !(condition_I) )																												  \

				{																																											      \

						WACOM_ASSERT( !assertString_I );																				      \

						return NULL;																																	   \

				}																																											      \

		}																																													      \

		while ( 0 )

 

//////////////////////////////////////////////////////////////////////////////

// Our Global Information

#include "ResourceEnums.h"

 

// Language Enumeration...

 

// NOTE: These language codes reside in the Localizable.strings file with the 

//					      key "Language". Make sure the value in Localizable.strings gets updated 

//					      to match any value change of the language code here. 

enum ELanguage

{

		EAmericanEnglish=0,									      // 0

		EChineseSimplified,										// 1

		EChineseTraditional,									       // 2

		EEuropeanEnglish,										  // 3

		EFrench,																  // 4

		EGerman,																		// 5

		EJapanese,															       // 6

		EKorean,																 // 7

		EItalian,														   // 8

		ESpanish,																// 9

		EPortuguese,													    // 10

		EBrazilian,															       // 11

		EDutch,																   // 12

		ERussian,																// 13

		ESwedish,																// 14

		EPolish,																   // 15

		EDanish,																  // 16

		EFinnish,														 // 17

		ENorwegian,															    // 18

		ETurkish,																// 19

		ECzech,																   // 20

		EGreek,																   // 21

		EHungarian,															     // 22

		ESlovak,																  // 23

		LAST_ELANGUAGE

};

 

 

 

// Tablet Connection identification

#define IS_SERIAL(tt) ( (tt == EPLSerialTablet) )

#define IS_USB(tt)  ( (tt == EUDUSBTablet) || \

																(tt == EFTUSBTablet) || (tt == EISDUSBTablet) || \

																(tt == ECTEUSBTablet) || (tt == EPTZUSBTablet) || \

																(tt == ECFTUSBTablet) || (tt == EDTIUSBTablet) || \

																(tt == EPTKUSBTablet) || (tt == ECT_USBTablet)) 

#define IS_BT(tt)		     ( (tt == EWTEUSBTablet) || (tt == EPTKBTTablet) )

 

#define IS_NON_HIDROUTER(tt) (IS_BT(tt) || (tt == EPLSerialTablet))

 

// Certain tablets may be connected over two different modes. Those tablets must 

// be identified by model not type.

#define IS_DUAL_CONNECTION_MODE(tabletModel)	( (tabletModel == EPTK540WL) )

 

 

 

// Tablet Type Enumeration...

enum ETabletType

{

		EPLSerialTablet						       =  1,

		EUDUSBTablet									=  8,

		EFTUSBTablet									 = 13,

		EISDUSBTablet								       = 15,

		EPTZUSBTablet								      = 17,

		EWTEUSBTablet								     = 18,

		ECFTUSBTablet								      = 19,

		EDTIUSBTablet								       = 21,

		ECTEUSBTablet								      = 23,

		EPTKUSBTablet								      = 24,

		ECT_USBTablet								      = 25,

		EPTKBTTablet									= 26,

		EWLReceiverTablet						 = 27,

 

		NUMBER_OF_TABLET_TYPES

};

 

#define IS_ET(tm)								   (IS_CTE(tm) || IS_BAMBOO(tm))

#define IS_CTE(tm)								((tm == ECTE440) || (tm == ECTE450) || (tm == ECTE640) || (tm == ECTE650))

#define IS_BIRCH(tm)							    ((tm == ECTE460) || (tm == ECTE660))

#define IS_BAMBOO(tm)				       (IS_MTE(tm) || IS_CF(tm) || IS_B1(tm))

#define IS_MTE(tm)							       ((tm == EMTE450))

#define IS_CF(tm)								   ((tm == ECTE450) || (tm == ECTE650))

#define IS_B1(tm)								   ((tm == ECTF430) || (tm == ECTE631))

#define IS_PL(tm)								   ((tm >= FIRST_TABLET_PL) && (tm <= MAX_TABLET_PL))

#define IS_ADONIS(tm)					 (tm == EDTU1031)

#define IS_PL_600(tm)					   ((tm == EPL600) || (tm == EPL600SX))

#define IS_PL_720(tm)					   ((tm == EPL720) || (tm == EPL720A))

#define IS_CINTIQ(tm)					   ((tm == EDTZ2100) || (tm == EDTZ2001W) || (tm == EDTZ1201W) || \

																				(tm == EDTU1931) || (tm == EDTU2231) || (tm == EDTU1631) || (tm == EDTU1031) || \

																				IS_MONET(tm) || IS_OSPREY(tm) || IS_RIESLING(tm) || IS_K2(tm))

//#define IS_FT changed to IS_CTF because of new naming convention

#define IS_CTF(tm)						 ((tm == EFT0203) || (tm == ECTF220) || (tm == ECTF420) || \

																				(tm == ECTF221) || IS_MTE(tm) || IS_B1(tm))

//ISD products are from the component group within wacom

#define IS_ISD(tm)						 (((tm >= EVISD) && (tm <= MAX_TABLET_ISD)) || \

																				((tm >= EISDGenUSB_512) && (tm <= MAX_TABLET_ISDEXTENDED)) ||\

																				(tm == ESP0203))

//VISD products are for the vertical market

#define IS_VISD(tm)							       ((tm == EISD10) || (tm == EISD8))

#define IS_INTUOS3(tm)					((tm >= EPTZ430) && (tm <= MAX_TABLET_PTZ))

#define IS_INTUOS3EXT(tm)				((tm >= EDTZ2001W) && (tm <= MAX_TABLET_PTZEXTENDED))

#define IS_PTZ(tm)						 (IS_INTUOS3(tm) || IS_INTUOS3EXT(tm))

#define IS_PTZW(tm)							     ((tm == EPTZ1231W) || (tm == EPTZ631W) || (tm == EPTZ431W) || IS_DTZW(tm))

#define IS_WTE(tm)							       (tm == EWTE600)

#define IS_DTI(tm)						 (tm == EDTI520)

#define IS_PALMREST(tm)				    ((EISDW8002 == (tm)) || (EISDNico == (tm)) || (EISDAsusENote == (tm)))

#define IS_ENOTE(tm)							   (tm == EISDAsusENote)

#define IS_LENOVO_DISPLAY(tm)      (tm == EISDLenovoDisplay)

#define IS_INTEGRATED(tm)				(IS_PL(tm) || IS_CINTIQ(tm) || (IS_ISD(tm) && !IS_PALMREST(tm)) || IS_DTI(tm))

#define IS_PTZ_CINTIQ(tm)		  ((tm == EDTZ2100) || (tm == EDTZ2001W) || (tm == EDTZ1201W))

#define IS_DTZW(tm)							     ((tm == EDTZ2001W) || (tm == EDTZ1201W))

#define IS_INTUOS4_SMALL(tm)	 (tm == EPTK440W)

#define IS_INTUOS4(tm)					(IS_INTUOS4_SMALL(tm) || (tm == EPTK640W) || (tm == EPTK840W) || \

																				(tm == EPTK1240W) || (tm == EPTK540WL))

#define IS_MONET(tm)							  (tm == EDTK2100)

#define IS_OSPREY(tm)											 (IS_OSPREY_PEN_ONLY(tm) || IS_OSPREY_PEN_TOUCH(tm) || IS_OSPREY_PEN_VALUE(tm) || IS_OSPREY_PEN_VALUE_TOUCH(tm))

#define IS_OSPREY_PEN_ONLY(tm)				    (tm == EDTK2400)

#define IS_OSPREY_PEN_TOUCH(tm)				  (tm == EDTH2400)

#define IS_OSPREY_PEN_VALUE(tm)				  (tm == EDTK2200)

#define IS_OSPREY_PEN_VALUE_TOUCH(tm)   (tm == EDTH2200)

#define IS_RIESLING(tm)								      (IS_RIESLING_PEN(tm) || IS_RIESLING_PEN_TOUCH(tm))

#define IS_RIESLING_PEN(tm)					     (tm == EDTK2241)

#define IS_RIESLING_PEN_TOUCH(tm)	       (tm == EDTH2242)

#define IS_K2(tm)								   (tm == EDTK1300)

#define IS_PTK_CINTIQ(tm)		  (IS_MONET(tm) || IS_OSPREY(tm))

#define IS_PTK_PEN_SMALL(tm)	 (IS_INTUOS4_SMALL(model) || IS_COBRA_PEN_ONLY_SMALL(model))

#define IS_PTK_PEN_LARGE(tm)	 ((IS_INTUOS4(model) && !IS_INTUOS4_SMALL(model)) || \

																				(IS_COBRA(model) && !IS_COBRA_PEN_TOUCH(model) && !IS_COBRA_PEN_ONLY_SMALL(model)))

#define IS_PTH_PEN_TOUCH_SMALL(tm)	  (tm == EPTH450)

#define IS_PTH_PEN_TOUCH_LARGE(tm)	  ((tm == EPTH650) || (tm == EPTH850))

#define IS_COBRA(tm)							   ((tm == EPTK450) || (tm == EPTK650) || (tm == EPTH450) || \

																				(tm == EPTH650) || (tm == EPTH850))

#define IS_COBRA_PEN_ONLY(tm)      ((tm == EPTK450) || (tm == EPTK650))

#define IS_COBRA_SMALL(tm)			    ((tm == EPTK450) || (tm == EPTH450))

#define IS_COBRA_PEN_ONLY_SMALL(tm)       (tm == EPTK450)

#define IS_COBRA_PEN_ONLY_LARGE(tm)       (tm == EPTK650)

#define IS_COBRA_PEN_TOUCH(tm)   (IS_PTH_PEN_TOUCH_SMALL(tm) || IS_PTH_PEN_TOUCH_LARGE(tm))

#define IS_SQUARE(tm)					 (tm == EPTZ1230)

#define IS_MAPLE(tm)							   ((tm >= ECTT460) && (tm <= ECTH661SE))

#define IS_MAPLE_ONE(tm)		 ((tm == ECTL460) || (tm == ECTL660))

#define IS_MAPLE_FUN(tm)		 ((tm == ECTH461) || (tm == ECTH661) || (tm == ECTH461P) || \

																				(tm == ECTH661P) || (tm == ECTH461SE) || (tm == ECTH661SE))

#define IS_MAPLE_PT(tm)				    ((tm == ECTH460) || (tm == ECTH461) || (tm == ECTH661) || \

																				(tm == ECTH460P) || (tm == ECTH461P) || (tm == ECTH661P))

#define IS_MAPLE_PLUS(tm)				((tm >= ECTT460P) && (tm <= ECTH661P))

#define IS_MAPLE_SE(tm)				    ((tm >= ECTH461SE) && (tm <= ECTH661SE))

#define IS_MAPLE_UPGRADE(tm)       (IS_MAPLE_PLUS(tm) || IS_MAPLE_SE(tm))

#define IS_MAPLE_CLASSIC(tm)	  (IS_MAPLE(tm) && !IS_MAPLE_UPGRADE(tm))

#define IS_IRONWOOD(tm)				   ((tm >= ECTT470) && (tm <= MAX_TABLET_CCT))

#define IS_IRONWOOD_P(tm)			       ((tm == ECTL470))

#define IS_IRONWOOD_PT(tm)			     ((tm == ECTH470_ECTH471) || (tm == ECTH670_ECTH671))

#define IS_IRONWOOD_T(tm)			       (tm == ECTT470)

#define IS_TOUCH_ONLY(tm)			      ((tm == ECTT460) || (tm == ECTT460P) || (tm == ECTT470))

#define IS_TOUCH_CAPABLE(tm)	(IS_TOUCH_ONLY(tm) ||(tm == ECTH460) ||(tm == ECTH461) || \

																				(tm == ECTH661) || (tm == ECTH460P) || (tm == ECTH461P) || \

																				(tm == ECTH661P) || (tm == ECTH461SE) || (tm == ECTH661SE) || \

																				(tm == ECTH470_ECTH471) || (tm == ECTH670_ECTH671) || \

																				(tm == EPTH450) || (tm == EPTH650) || (tm == EPTH850) || \

																				(tm == EDTH2400) || (tm == EDTH2242) || (tm == EDTH2200))

#define IS_TOUCH_ABSOLUTE(tm)     (IS_OSPREY_PEN_TOUCH(tm) || IS_RIESLING_PEN_TOUCH(tm) || IS_OSPREY_PEN_VALUE_TOUCH(tm))

 

#define SUPPORTS_LION_GESTURES(tm) (IS_COBRA(tm) || IS_TOUCH_ABSOLUTE(tm) ||IS_IRONWOOD(tm))

 

 

#define IS_SERIAL_ISD(tm)		  ((tm == EVISD) || (tm == EISDWACF008) || (tm == EISDWACF009) || \

																				(tm == EISDWACF00A) || (tm == EISDWACF00B) || (tm == EISDWACF00C) || \

																				(tm == EISDFUJ02E7) || (tm == EISDWACF00D) || (tm == EISDWACF00E) || \

																				(tm == EISDWACF010) || (tm == EISDFUJ02E9))

 

#define IS_SUPPORTS_HID(tm)	     (IS_PL(tm) && !IS_PL_600(tm))

 

 

 

// Tablet Model Enumeration...

enum ETabletModel

{

		EWLReceiver																	   = 50,

 

// The ET series - continued at the end of the enum list.

		ECTE440																		 = 85, // Graphire4 4x5

		ECTE640																		 = 86, // Graphire4 6x8

		ECTE450																		 = 87, // Bamboo Fun 4x5

		ECTE650																		 = 88, // Bamboo Fun 6x8

		MAX_TABLET_ET = 89,

 

		EFT0203																		 = 91,

		ECTF220																		 = 92, // Volito2 2x3

		ECTF420																		 = 93, // Volito2 4x5

		ECTF221																		 = 94, // PenPartner2

		EMTE450																				= 95, // Bamboo (My Office)

		ECTF430																		 = 96, // Bamboo One Small (Sparrow)

		ECTE631																		 = 97, // Bamboo One Medium

		MAX_TABLET_FT = 99,

 

// The PL series

// Take the model and div 10 subtract 10 and add 100

		FIRST_TABLET_PL													       = 100,

		EPL510																		   = 142, // does not adhere to math noted above (should be 141)

		EPL521																		   = 143, // DTF-521

		EPL600																		   = 150,

		EPL600SX																			       = 151,

		EPL700																		   = 155,

		EPL710																		   = 156,

		EPL720																		   = 157, // DTF-720

		EPL720A																		 = 158, // DTF-720 with buttons

		EDTU1931																			      = 161, // Monarch

		EDTU2231																			      = 162, // Queen

		EDTU1631																			      = 163, // Glasswing

		EDTU1031																			      = 164, // Adonis

		MAX_TABLET_PL = 199,

 

		EVISD																		     = 220,

		EISD10																		    = 221,

		EISD12																		    = 222,

		EISDGenUSB																	  = 223,

		EISD5																				      = 224,

		EISD14																		    = 225,

		EISD8																				      = 226,

		EISD4																				      = 227,

		EISDW8002																	    = 228,

		EISDGenSer																	    = 229,

		MAX_TABLET_ISD = 230,

 

		ESP0203																		  = 240,

		MAX_TABLET_SP = 241,

 

		//Intuos3 series

		EPTZ430																		 = 260, // 4 x 5

		EPTZ630																		 = 261, // 6 x 8

		EPTZ930																		 = 262, // 9 x 12

		EPTZ1230																			       = 263, // 12 x 12

		EPTZ1231W																	    = 264, // 12 x 19

		EDTZ2100																			      = 265,

//	      EPTZ531WBT																	 = 266, // dead

		EPTZ631W																			      = 267, // 6 x 11

		EPTZ431W																			      = 268, // 4 x 6

		MAX_TABLET_PTZ = 269,

 

		//Bluetooth

		EWTE600																				= 270,

 

		EDTI520																		 = 280,

 

		// Intuos3 series (extended)

		EDTZ2001W																	   = 300, // Cintiq 20WSX

		EDTZ1201W																	   = 301, // Cintiq 12W (DTZ-1200)

		MAX_TABLET_PTZEXTENDED = 319,

 

		// Intuos4 (Kestrel) series

		EPTK440W																			     = 320, // Small

		EPTK640W																			     = 321, // Medium

		EPTK840W																			     = 322, // Large

		EPTK1240W																	   = 323, // XL

		EPTK540WL																	   = 324, // Wireless

		EDTK2100																			      = 326, // Cintiq 21UX 2

		EDTK2400																			      = 327, // Cintiq 24HD (Osprey Pen)

		EDTH2400																			      = 328, // Cintiq 24HDT (Osprey Touch)

		EDTK2400Out																	= 329, // Cintiq 24HD (HidRouter Touch output Collection)

		EDTK2200																			      = 330, // Cintiq 22HD (Osprey Pen Value)

		EDTK2241																			      = 331, // DTK-2241 (Riesling Pen)

		EDTH2242																			      = 332, // DTH-2242 (Riesling Pen Touch)

		EDTH2200																			      = 333, // Cintiq 22HDT (Osprey Pen Touch Value)

 

		// Intuos5 (Cobra)

		EPTK450																		 = 334, // Small Pen

		EPTK650																		 = 335, // Medium Pen

		EPTH450																		 = 336, // Small Pen & Touch

		EPTH650																		 = 337, // Medium Pen & Touch

		EPTH850																		 = 338, // Large Pen & Touch

 

		EDTK1300																			      = 339, // Cintiq 13HD (K2)

		MAX_TABLET_PTK													      = 340,

 

		//ISD series (extended)

		EISDGenUSB_512														  = 400,

		EISDNico																				= 401,

		EISDNewUSB																	  = 402,

		EISDAsusENote														      = 403,

		EISDNewUSBWithMT													     = 404,

		EISDMTNoPen																	= 405, // Needed for multitouch API

		EISDGenI2C																	    = 406,

		EISDLenovoDisplay														= 407,

		EISDGenUSB_V4														    = 408,

		MAX_TABLET_ISDEXTENDED = 499,

 

		// Maple series

		ECTT460																		 = 500, // Bamboo Touch

		ECTH460																				= 501, // Bamboo Pen & Touch

		ECTH461																				= 502, // Bamboo Fun small (Pen & Touch)

		ECTH661																				= 503, // Bamboo Fun medium (Pen & Touch)

		ECTL460																		 = 504, // Bamboo Pen small

		ECTL660																		 = 505, // Bamboo Pen medium

		// Maple plus series.

		ECTT460P																			       = 506, // Bamboo Touch Plus

		ECTH460P																			      = 507, // Bamboo Pen & Touch Plus

		ECTH461P																			      = 508, // Bamboo Fun small Plus (Pen & Touch)

		ECTH661P																			      = 509, // Bamboo Fun medium Plus (Pen & Touch)

		ECTH461SE																	    = 510, // Bamboo Fun Small Special Edition (Pen & Touch)

		ECTH661SE																	    = 511, // Bamboo Fun Medium Special Edition (Pen & Touch)

		// Ironwood series.

		ECTT470																		 = 512, // Ironwood Small Touch

		ECTL470																		 = 513, // Ironwood Small Pen 

		ECTH470_ECTH471													       = 514, // Ironwood Small Pen Touch 

		ECTH670_ECTH671													       = 515, // Ironwood Medium Pen Touch 

		MAX_TABLET_CCT = 549,

 

		// ISD Touch Sensors

		EISDUSB93																	     = 550,

		EISDUSB9A																	    = 551,

		EISDWACWISD																      = 552,

		EISDUSBCAPPLUS														 = 553,

		EISDUSBE2																	    = 554,

		EISDUSBE3																	    = 555,

		EISDUSBE4																	    = 556,

		EISDUSBE6																	    = 557,

		EISDWACF008																       = 558,

		EISDWACF009																       = 559,

		EISDWACF00A																       = 560,

		EISDWACF00B																       = 561,

		EISDWACF00C																       = 562,

		EISDFUJ02E7																	 = 563,

		EISDWACF00D																       = 564,

		EISDWACF00E																       = 565,

		EISDWACF010																       = 566,

		EISDFUJ02E9																	 = 567,

		EISDSERIALCAPPLUS													   = 578,

		EISDUSBED																	    = 579,

		EISDUSBG8Demo														   = 580,

		EISDUSBEETI																	= 581,

		EISDUSBG8																	    = 582,

		MAX_TABLET_ISDT													     = 600,

 

		// The ET series continued....

		ECTE460																		 = 601, // Birch S

		ECTE660																		 = 602, // Birch M

		MAX_TABLET_ET_TABLET												= 649,

 

		NUMBER_OF_TABLET_MODELS = 650,

		EInvalidModel							 = NUMBER_OF_TABLET_MODELS,

		EVirtualHID									    = NUMBER_OF_TABLET_MODELS+1,

		EVirtualTHID							  = NUMBER_OF_TABLET_MODELS+2,

};

 

typedef enum ETabletCalibrationSize

{

		ERecalibrate4x5,

		ERecalibrate6x8,

		ERecalibrate9x12,

		ERecalibrate12x12,

		ERecalibrate12x18,

		ERecalibrateDTZ2100,

		ERecalibrate6x8Bluetooth,		       // dead

		ERecalibrate6x11,

		ERecalibrate4x6

}	      ETabletCalibrationSize;

 

#define    FIRST_TABLE_MODEL					 EUD0608

 

#define    MAX_TABLET_INDEX					 (NUMBER_OF_TABLET_MODELS + 1)

 

#define    MONITORNAMESIZE			    256	  // see udtablet.h for the PL Names

 

typedef enum EPuckTransButton

{

		EPuckButton1 = 1,

		EPuckButton2,

		EPuckButton3,

		EPuckButton4,

		EPuckButton5,

		EPuckButton6,

		EPuckButton7,

		EPuckButton8,

		EPuckButton9,

		EPuckButton10,

		EPuckButton11,

		EPuckButton12,

		EPuckButton13,

		EPuckButton14,

		EPuckButton15,

		EPuckButton16

} EPuckTransButton;

 

typedef enum EMouseTransButton

{

		EMouseLeftButton = 1,

		EMouseMiddleButton,

		EMouseRightButton,

		EMouseLowerRightButton,

		EMouseLowerLeftButton,

		EMouseRoller = 16,

		EMouseFingerWheel = 32

} EMouseTransButton;

 

 

typedef enum EStylusTransButton

{

		EStylusTipButton = 1,

		EStylusLowerSideButton,

		EStylusUpperSideButton,

		EStylusEraserButton,

		EStylusWheel = 32

} EStylusTransButton;

 

typedef enum ETabletControls

{

		// ptz buttons

		ETabletButtonLeft1,

		ETabletButtonLeft2,

		ETabletButtonLeft3,

		ETabletButtonLeft4,

		ETabletButtonRight1,

		ETabletButtonRight2,

		ETabletButtonRight3,

		ETabletButtonRight4,

		ETabletButtonsLeft,

		ETabletButtonsRight,

		EPTZTouchStripL,

		EPTZTouchStripR,

		ETabletWheelCenter,

		ETabletTouchRingCenter,

		ETabletTouchRingLeft,

		// and a terminator

		ETabletControlsLastControl,

	       
		// Pinned enums

		ETabletButton1 = ETabletButtonLeft1,

		ETabletButton2 = ETabletButtonLeft2,

		ETabletButton3 = ETabletButtonLeft3,

		ETabletButton4 = ETabletButtonLeft4,

		ETabletButton5,

		ETabletButton6,

		ETabletButton7,

		ETabletButton8,

		ETabletButtonI = ETabletButton1,

		ETabletButtonO = ETabletButton2,

	       
		EPTZTouchStripModDefault   = 0,

		EPTZTouchStripModOuter		      = 1,

		EPTZTouchStripModInner		      = 2,

	       
		EPTKTouchRingMode1					   = 0,

		EPTKTouchRingMode2					   = 1,

		EPTKTouchRingMode3					   = 2,

		EPTKTouchRingMode4					   = 3,

	       
		EDTKTouchStripMode1					  = 0,

		EDTKTouchStripMode2					  = 1,

		EDTKTouchStripMode3					  = 2,

		EDTKTouchStripMode4					  = 3,

 

		// These are for Osprey Touch Ring function ordering

		// when registering views.

		EDKTouchRingFunctionTop		   = 0,

		EDKTouchRingFunctionMiddle	       = 1,

		EDKTouchRingFunctionBottom	      = 2,

 

		// These are for Osprey Express Key function ordering

		// when registering views.

		EDKExpressKeyFunction1		      = 0,

		EDKExpressKeyFunction2		      = 1,

		EDKExpressKeyFunction3		      = 2,

		EDKExpressKeyFunction4		      = 3,

		EDKExpressKeyFunction5		      = 4,

	       
		EPTHTouchRingMode1					   = 0,

		EPTHTouchRingMode2					   = 1,

		EPTHTouchRingMode3					   = 2,

		EPTHTouchRingMode4					   = 3,

 

		// These are special enums used for Cobra TouchRing mode ordering.

		// They are special because the driver will use them to determine

		// the actual mode index (0,1,2 or 3) based on tablet flipped state.

		EPTHTouchRingModeUpperLeft	     = 256,

		EPTHTouchRingModeUpperRight= 257,

		EPTHTouchRingModeLowerRight= 258,

		EPTHTouchRingModeLowerLeft = 259,

	       
} ETabletControls;

 

 

// Please do not change the order of the items in this enum. Doing so will

// require changes to the MacOS X nib files.

typedef enum EMenuFunction

{

		EMenuIgnored									 = 0,	  // don't do anything

		EMenuKeystroke								     = 1,	  // play key sequence

		EMenuMacro_Deprecated		       = 2,	  // played a QuicKeys macro on Mac OS 9

		EMenuSofter											   = 3,	  // for GD set to Softest

		EMenuNormal											 = 4,	  // for GD set to Normal

		EMenuFirmer											  = 5,	  // for GD set to Hardest

		EMenuRelative									= 6,	  // for GD set to Relative

		EMenuAbsolute								       = 7,	  // for GD set to Absolute

		EMenuZip													       = 8,	  // for GD set to Zip

		EMenuMakeSofter						   = 9,	  // for UD to make one step softer

		EMenuMakeFirmer						  = 10, // for UD to make one step softer

		EMenuDefault									 = 11, // set menu to default function

		EMenuRunApp											= 12, // run an application

		EMenuToggleInking								= 13, // Toggle Ink Anywhere off/on

		EMenuBack											     = EBack,

		EMenuForward									= EForward,

		ELAST_MENU_FUNCTION

} EMenuFunction;

 

 

typedef enum EPopUpFunction

{

		EPopUpKeystroke						   = 0,

		EPopUpMacro_Deprecated		      = 1,

		EPopUpScalingAbsolute			  = 2,

		EPopUpScalingRelative			    = 3,

		EPopUpScalingZip						   = 4,

		EPopUpRunApp								      = 5,

		EPopUpNoFunction						 = 6,

		EPopUpSubmenu								    = 7,

		EPopUpScalingZipLeft					    = 8,

		EPopUpScalingZipRight			   = 9,

		ELAST_POPUP_FUNCTION

} EPopUpFunction;

 

/*menu names for these functions are held in the Localizable.strings

 file on the Mac. There is a correspondence between the enumeration value

 set here, and the string value there. If you add to this enumeration, be sure

 to add a string to the String list 1094 as well, otherwise string values after

 the new enumeration value here won't match*/

typedef enum EWacomFunction

{

		EWacomFuncRadialSubmenu		  = 0,

		EWacomFuncKeystroke					  = 1,

		EWacomFuncRunApp							     = 2,

		EWacomFuncScalingAbsolute = 3,

		EWacomFuncScalingRelative   = 4,

		EWacomFuncRunBrowser				       = 5,

		EWacomFuncRunEMail					   = 6,

		EWacomFuncMediaPlayPause = 7,

		EWacomFuncMediaNextTrack		= 8,

		EWacomFuncMediaPrevTrack = 9,

		EWacomFuncMediaVolumeUp				= 10,

		EWacomFuncMediaVolumeDown	   = 11,

		EWacomFuncDisabled					     = 12,

		EWacomFuncCloseRadialMenu	       = 13,

		EWacomFuncPrecisionMode		   = 14,

		EWacomFuncDisplayToggle		    = 15,

		EWacomFuncCPLToggle					 = 16,

		EWacomFuncSwitchApp					 = 17,

		ELAST_WACOM_FUNCTION,

		EWacomFuncMediaGroup,		      // ELAST_WACOM_FUNCTION + 1

} EWacomFunction;

 

 

typedef enum EDTCycleImage

{

		EDTCycleImageTop = 0,

		EDTCycleImageMidOn,

		EDTCycleImageMidOff,

		EDTCycleImageEndOn,

		EDTCycleImageEndOff,

		EDTCycleImageTopLone,

		ELAST_DTCYCLE_IMAGE

} EDTCycleImage;

 

 

typedef enum EJoystickSensitivity

{

		EJoystickOff = 0,

		EJoystickSlow,

		EJoystickMedium,

		EJoystickFast,

		EJoystickMAX

} EJoystickSensitivity;

 

 

typedef enum ESignalState

{

		ESignalFull = 0,

		ESignalNoTablet,

		ESignalNoReceiver,

		ESignalMAX

} ESignalState;

 

 

typedef enum EAspectType

{

		eAspectTypeOneToOne = 0,

		eAspectTypeProportional,

		eAspectTypeToFit,

		ELAST_ASPECT

 

} EAspectType;

 

 

typedef enum PTKBrightness

{

		ePTKBrightnessOff = 0,			   // 9 levels for Adonis DTU-1031

		ePTKBrightnessLevel1,			   // Mapping to four levels will occur in

		ePTKBrightnessLevel2,			   // tablet code for Kestrel WL and other

		ePTKBrightnessLevel3,			   // Unitsm as follows:

		ePTKBrightnessLevel4,			   // Level 1 - 3 Dim

		ePTKBrightnessLevel5,			   // Level 4 - 6 Median

		ePTKBrightnessLevel6,			   // Level 7 - 9 Bright

		ePTKBrightnessLevel7,

		ePTKBrightnessLevel8,

		ePTKBightnessMax,

		ELAST_PTKBRIGHTNESS

} PTKBrightness;

 

 

typedef enum EControlType

{

		eControlTypeButton,					       // any button (Express Key or capacitive)

		eControlTypeButtonEK,			  // Express Key button only

		eControlTypeTouchStripMod,

		eControlTypeWheel,

		eControlTypeSlider,

		eControlTypeTouchStrip,

		eControlTypeTouchRing,

		eControlTypeDisplay,

		ELAST_CONTROL_TYPE

 

} EControlType;

 

 

typedef enum EControlPosition

{

		eControlPositionLeft,

		eControlPositionRight,

		eControlPositionTop,

		eControlPositionBottom,

		eControlPositionTransducer,

		eControlPositionNone,

		ELAST_POSITION

} EControlPosition;

 

 

typedef enum EInputAreaType

{

		eInputAreaTypeFullTablet = 0,

		eInputAreaTypePortionTablet,

		eInputAreaTypeInsetTablet,

		eInputAreaTypeLeftHandedZipNavigation,

		eInputAreaTypeLeftHandedZipDrawing,

		eInputAreaTypeRightHandedZipNavigation,

		eInputAreaTypeRightHandedZipDrawing,

		eInputAreaTypeLucyLargeArea,

		eInputAreaTypeLucyMediumArea,

		eInputAreaTypeLucySmallArea,

		eInputAreaTypeInset6x8,

		ELAST_INPUT_AREA_TYPE

} EInputAreaType;

 

 

typedef enum EInputAreaPosition

{

		eInputAreaPositionUpperLeft = 0,

		eInputAreaPositionLowCenter,

		ELAST_INPUT_AREA_POSITION

} EInputAreaPosition;

 

 

typedef enum EDisplayAreaType

{

		eDisplayAreaTypeFullDisplay = 0,

		eDisplayAreaTypePortionDisplay,

		ELAST_DISPLAY_AREA_TYPE

} EDisplayAreaType;

 

 

// Event definitions for taglist event reporting and state

// and passing data state info to pressure button objects.

typedef enum EBatteryState

{

		EBatteryDraining						     = 0, // signal from tablet (not plugged in)

		EBatteryUnknown						   = 1, // no signal

		EBatteryUnAttached						= 2, // wireless tablet not found/disconnected

		EBatteryPluggedInCharging      = 4, // Battery is charging from external power

		EBatteryPluggedInCharged       = 5  // Battery is charged but tablet still plugged in

} EBatteryState;

 

typedef enum ETabletFlags

{

		ETabletFlagsClear																						    = 0x0,

		ETabletFlagsInvalid																				 = 0x0,

		ETabletFlagsAreValid																					      = 0x1,

		ETabletFlagsDriverHasNotShownReminder									     = 0x2,

										// was ETabletFlagsCalibrationReminderNeedsShown

		ETabletFlagsTabletHasNotBeenCalibrated									       = 0x4,

										// was ETabletFlagsCouldShowCalibrationReminder

		ETabletFlagsTabletHasNotShownDisplayToggleWarning	 = 0x8,

		ETabletFlagsTabletDontDisplayToggleWarnings				      = 0x10,

		ETabletFlagsMax																						     = 0xffffffff,

		ETabletFlagsSet																						       = 0xf0000000,

 

		ETabletFlagsTemporary			   =	      ETabletFlagsDriverHasNotShownReminder

																				|		ETabletFlagsTabletHasNotShownDisplayToggleWarning,

 

		ETabletFlagsDefaultTablet       =	      ETabletFlagsAreValid

																				|		ETabletFlagsTabletHasNotShownDisplayToggleWarning,

 

		ETabletFlagsDefaultCintiq       =	      ETabletFlagsDefaultTablet

																				|	       ETabletFlagsDriverHasNotShownReminder

																				|	       ETabletFlagsTabletHasNotBeenCalibrated

}	      ETabletFlags;

 

#define FLAGS_SAY_SHOW_CALIBRATION_DIALOG(flags)	    \

						(	       (flags & ETabletFlagsDriverHasNotShownReminder) && \

								(flags & ETabletFlagsTabletHasNotBeenCalibrated) \

						)

 

#define FLAGS_SAY_SHOW_DISPLAY_TOGGLE_DIALOG(flags)     \

						(	       (flags & ETabletFlagsTabletHasNotShownDisplayToggleWarning) && \

								!(flags & ETabletFlagsTabletDontDisplayToggleWarnings) \

						)

 

 

#define GENERAL_STYLUS_SERIAL_NUMBER 1

#define GENERAL_PUCK_SERIAL_NUMBER		      2

 

#define IS_PUCK(x) ( (x == EUDPuck) || (x == EETPuck) || (x == EET2Puck) || \

														(x == EGDSpuck) || (x == EGDLensCursor) || \

														(x == EGD16ButtonCursor) || (x == EGD3AnalogPuck) || \

														(x == EGDDipSwitchPuck) || (x == EGD3AnalogDialPuck) || \

														(x == EGDTiltRotationPuck) || \

														(x == EXDLensCursorTransducer) || \

														(x == EXDPuck4DTransducer) || \

														(x == EXDPuck2DTransducer) || (x == EXD2AnalogPuck) || \

														(x == EXD2AnalogNegPuck) || (x == EXD17ButtonPuck) || \

														(x == EXD4D6ButtonPuck) || (x == EXD2AnalogRotationPuck) || \

														(x == EFTPuck) || (x == EET3Puck) || (x == EPTZPuck2DTransducer) || \

														(x == EWTEPuck) || (x == EFTWheelPuck) || (x == EPTZLensCursorTransducer) || \

														(x == ECTEPuck) || (x == ECFPuck) || (x == EPTKLensCursorTransducer) || \

														(x == EPTKPuck4DTransducer))

 

#define IS_STYLUS(x) ((x == EUDPressureStylus) || (x == EETPressureStylus) || \

														(x == EET2PressureStylus) || (x == EGDPressureStylus) || \

														(x == EGDInkingPen) || (x == EGDStrokePen) || \

														(x == EGDAirBrush) || (x == EGDBarrelStylus) || \

														(x == EGDFatStylus) || (x == EXDClassicPressureStylus) || \

														(x == EXDStandardPressureStylus) || \

														(x == EXDDesignerPressureStylus) || \

														(x == EXDInkingPressureStylus) || \

														(x == EXDStrokePressureStylus) || \

														(x == EXDWoodPressureStylus) || \

														(x == EXDAirBrushPressureStylus) || \

														(x == EXD3AnalogStylus) || (x == EXD4AnalogStylus) || \

														(x == EXD10ButtonStylus) || \

														(x == EXDRotationWheelStylus) || (x == EXDRotationStylus) || \

														(x == EFTPen) || (x == EISDStylus) || \

														(x == EET3PressureStylus) || (x == EGDBrushStylus) || \

														(x == EPTZStandardPressureStylus) || (x == EPTZRotationStylus) || \

														(x == EPTZAirbrushPressureStylus) || (x == EPTZInkingPressureStylus) || \

														(x == EWTEPressureStylus) || (x == ECTFPressureStylus) || \

														(x == ECTFPrsrStylusWithEraser) || (x == EPTZClassicStylus) || \

														(x == EDTIMorphingPrsrStylusSideSwitch) || \

														(x == EDTIMorphingPrsrStylusEraser) || \

														(x == EDTIMorphingPrsrStylusSideSwitchEraser) || \

														(x == EDTIMorphingPrsrStylus) || (x == ECTEPressureStylus) || \

														(x == ECTF2PrsrStylusWithEraser) || (x == ECTF2PressureStylus) || \

														(x == EFTKidsPen) || (x == EPTZBrushStylus) || (x == EMTEStylus) || \

														(x == ECFStylus) || (x == ECTF3PressureStylus) || (x == EB1MPressureStylus) || \

														(x == EDTU1931PressureStylus) || (x == EDTU1031PressureStylus) || (x == EPTKGripPressureStylus) || \

														(x == EPTKClassicPressureStylus) || (x == EPTKInkingPressureStylus) || (x == EPTKRieslingGripPressureStylus) || \

														(x == EPTKArtPenStylus) || (x == EPTKAirBrushPressureStylus) || \

														(x == ECT_PressureStylus) || (x == ECT_PressureStylusWithEraser) || \

														(x == ECT_PressureStylusFunWithEraser) || (x == EET4PressureStylus) || \

														(x == ECT_PressureStylusLP170) || (x == ECT_PressureStylusEraserLP171) )

										// note that the EET3BadStylus advertises as a EET3PressureStylus

 

#define IS_AIRBRUSH(x) ((x == EGDAirBrush) || (x == EXDAirBrushPressureStylus) || \

																(x == EPTZAirbrushPressureStylus) || (x == EPTKAirBrushPressureStylus))

 

 

// Note - the ETransducerType enum values below MUST NOT CHANGE, as they

// are baked into preference files.  When adding a new stylus type, add to

// the end of the list before EMaxTransducerType and don't forget to set the

// enum value.

 

// Transducers (styluses, pucks/mice)

enum ETransducerType

{

		EGDPressureStylus														 = 0,

		EGDInkingPen																	 = 1,

		EGDStrokePen																	 = 2,

		EGDSpuck																					       = 3,

		EGDAirBrush																			  = 4,

		EGDLensCursor																      = 5,

		EGD16ButtonCursor															       = 6,

		EUDPressureStylus														 = 7,

		EUDPuck																				 = 8,

		ESDDeletedStylus														    = 9,													  //deleted per Intuos2 Project

//	      ESDClickStylus,														      //does not exist

		ESDDeletedPuck																      = ESDDeletedStylus +2,	   //deleted per Intuos2 Project

		EGD3AnalogPuck																    = 12,

		EGDDipSwitchPuck														 = 13,

		EGD3AnalogDialPuck													     = 14,

		EGDBarrelStylus														     = 15,

		EGDTiltRotationPuck													      = 16,

		EETPressureStylus														  = 17,

		EETPuck																				 = 18,

		EGDFatStylus																	  = 19,

		EET2PressureStylus														= 20,

		EET2Puck																					       = 21,

		EXDClassicPressureStylus								      = 22,

		EXDStandardPressureStylus								    = 23,

		EXDDesignerPressureStylus								    = 24,

		EXDInkingPressureStylus										       = 25,

		EXDStrokePressureStylus										       = 26,

		EXDWoodPressureStylus											= 27,

		EXDAirBrushPressureStylus								   = 28,

		EXDLensCursorTransducer										    = 29,

		EXDPuck4DTransducer													  = 30,

		EXDPuck2DTransducer													  = 31,

		EXD3AnalogStylus														  = 32,

		EXD2AnalogPuck																    = 33,

		EXD4AnalogStylus														  = 34,

		EXD2AnalogNegPuck															      = 35,

		EXD17ButtonPuck														  = 36,

		EXD10ButtonStylus																= 37,

		EXDRotationWheelStylus											= 38,

		EXD4D6ButtonPuck																= 39,

		EXDRotationStylus														  = 40,

		EXD2AnalogRotationPuck										       = 41,

		EFTPen																				    = 42,

		EFTPuck																				  = 43,

		EFTWheelPuck																	= 44,

		EISDStylus																			      = 45,

		EET3PressureStylus														= 46,

		EET3Puck																					       = 47,

		EET3BadStylus																       = 48,

		EPLGenericStylus														    = 49,

		EUPGenericStylus														   = 50,

		EUDUnknownStylus															       = 51,

		EGDBrushStylus																     = 52,

		EPTZStandardPressureStylus								  = 53,

		EPTZAirbrushPressureStylus								  = 54,

		EPTZRotationStylus														= 55,

		EPTZPuck2DTransducer													 = 56,

		EFunctionsPlaceholder											    = 57,

		EPTZInkingPressureStylus								      = 58,

		EWTEPressureStylus													       = 59,

		EWTEPuck																					      = 60,

		ECTFPressureStylus														= 61,

		ECTFPrsrStylusWithEraser								      = 62,

		EPTZClassicStylus														  = 63,

		EPTZLensCursorTransducer								   = 64,

		EDTIMorphingPrsrStylus											= 65, // tip only

		EDTIMorphingPrsrStylusSideSwitch				       = 66, // tip & 2 side switch

		EDTIMorphingPrsrStylusEraser							      = 67, // tip & eraser

		EDTIMorphingPrsrStylusSideSwitchEraser	     = 68, // tip, side switch & eraser

		ECTF2PressureStylus													      = 69,

		ECTF2PrsrStylusWithEraser								    = 70,

		ECTEPressureStylus														= 71,

		ECTEPuck																					       = 72,

		EFTKidsPen																			    = 73,

		EPTZBrushStylus														    = 74,

		EMTEStylus																			    = 75, // Bamboo (MyOffice)

		ECFStylus																				= 76, // Bamboo Fun

		ECFPuck																				  = 77,

		ECTF3PressureStylus													      = 78, // Bamboo One Small (Sparrow)

		EB1MPressureStylus													       = 79, // Bamboo One Medium

		EDTU1931PressureStylus										       = 80, // Monarch pen

		EPTKMetaFunctionPlaceholder							       = 81,

		EPTKGripPressureStylus											 = 82,

		EPTKClassicPressureStylus								     = 83,

		EPTKInkingPressureStylus								      = 84,

		EPTKArtPenStylus														  = 85,

		EPTKAirBrushPressureStylus								 = 86,

		EPTKLensCursorTransducer								   = 87,

		EPTKPuck4DTransducer													 = 88,

		ECT_PressureStylus														= 89, // Bamboo2 Pen only

		ECT_PressureStylusWithEraser							       = 90, // Bamboo2 Pen & Touch

		ECT_PressureStylusFunWithEraser					 = 91, // Bamboo2 Fun

		EET4PressureStylus														= 92,	// Birch 1024 levels of pressure for pen.

		ECT_PressureStylusLP170										      = 93, // Bamboo3 (Ironwood) Standard

		ECT_PressureStylusEraserLP171							    = 94,	// Bamboo3 (Ironwood) Premium

		ETouchIconForToolList											  = 95,

		EDTU1031PressureStylus										       = 96,	// Adonis stylus

		EPTKRieslingGripPressureStylus					    = 97, // Riesling Pen and Riesling Pen and Touch

		EMaxTransducerType

};

 

 

// Note - the EUDStylusType enum values below MUST NOT CHANGE, as they

// are baked into preference files.  When adding a new stylus type, add to

// the end of the list before EMaxUDStylusType and don't forget to set the

// enum value.

typedef enum EUDStylusType

{

		EUDErasingDuoSwitch = 0,		     // UP-801E

		EUDErasing	  = 1,			     // UP-701E

		EUDDouSwitch	= 2,			 // UP-801

		EUDUltraPen	 = 3,			    // UP-201

		EUDWideBodySmooth   = 4,		   // UP-421

		EUDWideBodyInk      = 5,		       // UP-401

		EUDHandwriting      = 6,			 // UP-211

		EUDPenPartner       = 7,			   // UP-703E

		EUTWirelessPen      = 8,			  // UP-712E

		EDTF510ErasingDuoSwitch = 9,	     // ??????

		EDTF720DuoSwitch    = 10,		    // it may or may not have an eraser

		//EMaxUDStylusType    = 11,  // OBSOLETE

		EUDPointClick       = 12,			 // OBSOLETE UP-241 DO NOT USE

		EUDSlimPen	  = 13,			  // MP-200

		EUDWideBodyPencil   = 14,		    // OBSOLETE UP-501

		// TODO - add new stylus types here

		EMaxUDStylusType										// let this one float

} EUDStylusType;

 

#define    INVALID_UDSTYLUS			   ( EUDStylusType )-1

 

typedef enum EShiftButtonState

{

		EForwardShift,

		ENormalShift,

		EBackwardShift

} EShiftButtonState;

 

 

typedef enum ROLLER_TYPE

{

		ETanPressure,

		EZAxis,

		EPressure,

		ERollerScroll,

		E15Button,

		EKeystroke,

		EDisabled,

		ELAST_ROLLER_TYPE

}	      ROLLER_TYPE;

 

 

typedef enum WHEEL_FUNCTION

{

		ELineScroll									      = 0,

		EPageScroll									      = 1,

		EKeystrokeScroll				     = 2,

		EScrollIgnore							   = 3,

		ELAST_WHEEL_FUNCTION

}	      WHEEL_FUNCTION;

 

 

typedef enum ETouchStripSensor

{

		ETouchStripBoth								     = 0,

		ETouchStripPen										       = 1,

		ETouchStripFinger								   = 2,

		ETouchStripNone								    = 3,

		ELAST_ONED_SENSOR

} ETouchStripSensor;

 

 

// Scroll Speed. Don't be fooled by the names. The Intuos4 just treats this as 

// 0=slowest, 6=fastest. Other tablets actually support page scroll and ignore 

// value 5. 

typedef enum EScrollSpeed

{

		EScrollPage									      = 0,

		EScrollVerySlow				     = 1,

		EScrollSlow									     = 2,

		EScrollMedium							= 3,

		EScrollFast									      = 4,

		// unadvertised					 = 5, 

		EScrollVeryFast				       = 6,

		EMaxScrollSpeed				    = EScrollVeryFast

} EScrollSpeed;

 

 

typedef enum EScrollDirection

{

		EScrollDirectionAll				  = 0,

		EScrollDirectionVertical	  = 1,

		EMaxScrollDirection					       = EScrollDirectionVertical

} EScrollDirection;

 

typedef enum EScrollBehavior

{

		EScrollBehaviorNatural					   = 0,

		EScrollBehaviorStandard					 = 1,

		EMaxScrollBehavior						= EScrollBehaviorNatural

} EScrollBehavior;

 

 

typedef enum E3FingerGestureBehavior

{

		E3FingerGestureDrag							       = 0,

		E3FingerGestureSwipeLeftRight = 1,

		E3FingerGestureDisabled					= 2,

		EMax3FingerGesture							       = E3FingerGestureDisabled

}E3FingerGestureBehavior;

 

 

// X and Y Tilt struct to map ReportedXYTilt packet data

typedef struct XYTILT

{

		XYTILT()

				: XTilt(0), YTilt(0)

		{}

		XYTILT( SINT16 x_I, SINT16 y_I)

				: XTilt(x_I), YTilt(y_I)

		{}

 

		SINT16    XTilt;

		SINT16    YTilt;

} XYTILT;

 

 

// Tablet Button taglist data

typedef struct ButtonEventData

{

		UINT8     position;  // Position container

		UINT8     posIndex;		// Index in the position container

		UINT8     state;			// EButtonEvent

		UINT8     id;					    // ID without regard to position

		bool	 asMessages;

} ButtonEventData;

 

 

// Ring/Strip taglist data

typedef struct SliderEventData

{

		UINT8 ctrlIndex;

		UINT8 mode;

		UINT8 position;

} SliderEventData;

 

 

// Structure for control override properties

typedef struct ExtProperty

{

		UINT8		     version;				   // Structure version

		UINT8		     tabletIndex;	      // 0-based index for tablet

		UINT8		     controlIndex;	   // 0-based index for control

		UINT8		     functionIndex;	 // 0-based index for control's sub-function

		UINT16   propertyID;			      // property ID (EExtProperties)

		UINT16   reserved;		  // alignment filler

		UINT32   dataSize;		  // number of bytes in data[] buffer

		UINT8		     data[1];				    // raw data

} ExtProperty;

 

typedef enum EExtProperties

{

		EExtPropertyControlCount,

		EExtPropertyFunctionCount,

		EExtPropertyAvailable,

		EExtPropertyMin,

		EExtPropertyMax,

		EExtPropertyOverride,

		EExtPropertyOverrideName,

		EExtPropertyOverrideIcon,

		EExtPropertyIconWidth,

		EExtPropertyIconHeight,

		EExtPropertyIconFormat,

		EExtPropertyLocation,

 

		EExtPropertyMAX

} EExtProperties;

 

 

// Roller sensitivity values - 2, 3 or 4.

typedef enum ERollerSensitivity

{

		ERangeMaximum = 2,

		ERangeMedium,

		ERangeMinimum

} ERollerSensitivity;

 

// Used to determine which popup menu items to use for QuickPoint

typedef enum EQuickPointMenuOptions

{

		EQuickPointNotSupported = 0,

		EQuickPointSingle,

		EQuickPointDouble

} EQuickPointMenuOptions;

 

 

// More Options used? in control Panel

typedef enum EDisclosureState

{

		EFewerOptions,

		EMoreOptions

} EDisclosureState;

 

 

// Connection status to control panel

typedef enum EConnectionStatus

{

		EConnected,

		ENotResponding,

		EOverriden,

		ETabletOff,

		EMaxConnectionStatus

} EConnectionStatus;

 

 

// Tablet mode (can be selected in the Control Panel by double clicking the tablet icon)

typedef enum ETabletMode

{

		EStandard,					       // Standard data packet rate

		ERecognition,			  // Higher data packet rate

		EDualtrack,

		ESingleOnly,

		ESingleLow,

 

		ELAST_TABLET_MODE

 

} ETabletMode;

 

 

// Tablet Mode support

typedef enum ETabletModeSupport

{

		ETModeSNone,		       // tablet mode not supported

		ETModeSDefault,    // tablet modes are standard and recon

		ETModeSLegacy,    // tablet modes are standard, recon and single

 

		ELAST_TModeS

} ETabletModeSupport;

 

 

enum EAppSwitchStimulus

{

		EAppSwitchButtonUp									      = 0, // ExpressKey-style switching (click-click-click)

		EAppSwitchButtonDown									 = 1, // " " "

 

		EAppSwitchToggleLinearSwitcher	   = 2, // on or off, a la 4-finger gesture

		EAppSwitchToggleFancySwitcher			    = 3, // Flip3D or Expose

		EAppSwitchToggleDesktop						     = 4,

		EAppSwitchToggleAppWindows					     = 5,			  //App Expos� in OSX 10.7

 

		// scrolling through Flip3D

		EAppSwitchNext												     = 10,

		EAppSwitchPrevious									       = 11,

		EAppSwitchCancel										  = 12,

		EAppSwitchSelect										    = 13,

 

		// scrolling through Linear Switcher

		EAppSwitchLinearNext									   = 15,

		EAppSwitchLinearPrevious				     = 16,

 

};

 

 

typedef enum ECalibrateFunction

{

		ECalUnknown,

		ECalTip,

		ECalSideSwitch,

		ECalEraser,

		ECal4Button,

		ECal16Button,

		EStopCalibrate,

		EStartCalibrate,

		ECalMaxFunction

} ECalibrateFunction;

 

 

enum EGesturePhase

{

		EGesturePhaseNone				= 0,

		EGesturePhaseBegin		= 1,

		EGesturePhaseMoving	     = 2,

		EGesturePhaseEnd		  = 3

};

 

 

enum ESettingsType

{

		ESettingsPreferences,

		ESettingsExpertSettings

};

 

 

enum EMultiTouchAPIClientType

{

		EMultiTouchAPIClientUnDefined			   = 0,

		EMultiTouchAPIClientAttachDetach	= 1,

		EMultiTouchAPIClientFingerPoints	 = 2,

		EMultiTouchAPIClientBlobs				   = 3,

		EMultiTouchAPIClientRawData			       = 4,

};

 

 

// constants -----------------------------------------------------------------

#define MAX_16BIT_UNSIGNED	  ((UINT16)65535U)

 

// type of transducer (used in transducer, taaif)

#define TRANSDUCER_TYPE_UNKNOWN			  ((UINT16)0x0000)

#define TRANSDUCER_TYPE_PENTIP		 ((UINT16)0x4000)

#define TRANSDUCER_TYPE_PUCK				    ((UINT16)0x8000)

#define TRANSDUCER_TYPE_PENERASER	 ((UINT16)0xC000)

#define TRANSDUCER_TYPE_MASK				   ((UINT16)0xC000)

 

#define TRANSDUCER_SERIAL_UNKNOWN				       ((UINT32)0)

#define TRANSDUCER_OPTIONAL_ID_UNKNOWN			   ((UINT8)0)

 

typedef UINT16 WACSTATUS;

 

#define FIRST_CONTAINER_INDEX		    ((UINT16)0)

 

//----------------------------------------------------------------------------

//

//			      Context ID is currently structured as a UINT16 as follows:

//

//					      T	      T	      T	      T	      T	      C	      C	      C	      C	      C	      C	      C	      C		C	      C	      C

//					      15 14 13 12 11 10 09 08 07 06 05 04 03 02 01 00

//

//			      Where T = Tablet index

//							      C = Context index

//

typedef UINT16 CONTEXT_ID;

 

// context packet number

typedef SINT16 PACKET_NUMBER;

 

#if defined(__cplusplus)

//NOTE some C modules need this file and class is undefined in C

 

// Routines to get globals...

class CPrefsInterface;

class CTagList;

class CObjectFactory;

 

CObjectFactory*								      GblGetObjFactReference( void );

extern "C" CPrefsInterface*     GblGetPrefsReference(void);

 

#if defined(UNIT_TESTING_BUILD) // {

		class CStubbyDriver;

		extern "C" CStubbyDriver       *GblGetTabletReference(void);

#else // } {

		class CTabletDriver;

		extern "C" CTabletDriver	 *GblGetTabletReference(void);

#endif // }

 

#endif //__cplusplus

 

#if !defined(GET_TIME_STAMP)

#define GET_TIME_STAMP() 0;

#endif

 

typedef UINT32 USER_IDENTIFIER;

#define DEFAULT_USER ( ( USER_IDENTIFIER ) 0 )

 

// Integer Constants / Defines...

#define MAX_APP_NAME_LENGTH    256

#define USE_CURRENT_APPLICATION 0xFFFF

 

// This is the max of the device-independent processed pressure

#define FULL_PRESSURE						      0x7fff

#define BASE_TAA_FULL_PRESSURE 1023

 

// Types to get raw packet from driver via an event --------------------------

// Note: This is used for cooked data too.

 

typedef UINT32 RAW_DATA_PRESENT;

 

#define RAW_PROX_PRESENT									     ((RAW_DATA_PRESENT)0x0001)

#define RAW_DEVICE_TYPE_PRESENT					      ((RAW_DATA_PRESENT)0x0002)

#define RAW_DEVICE_EXTID_PRESENT					    ((RAW_DATA_PRESENT)0x0004)

#define RAW_DEVICE_SERIAL_PRESENT			  ((RAW_DATA_PRESENT)0x0008)

#define RAW_XY_PRESENT										  ((RAW_DATA_PRESENT)0x0010)

#define RAW_PRESSURE_PRESENT						     ((RAW_DATA_PRESENT)0x0020)

#define RAW_TILT_PRESENT									       ((RAW_DATA_PRESENT)0x0040)

#define RAW_ROLLER_PRESENT									 ((RAW_DATA_PRESENT)0x0080)

#define RAW_ROTATION_PRESENT						    ((RAW_DATA_PRESENT)0x0100)

#define RAW_INDEX_PRESENT									   ((RAW_DATA_PRESENT)0x0200)

#define RAW_HEIGHT_PRESENT									 ((RAW_DATA_PRESENT)0x0400)

#define RAW_ANALOGUE1_PRESENT								((RAW_DATA_PRESENT)0x0800)

#define RAW_ANALOGUE2_PRESENT								((RAW_DATA_PRESENT)0x1000)

#define RAW_ANALOGUE3_PRESENT								((RAW_DATA_PRESENT)0x2000)

#define RAW_TABLET_BUTTONS_PRESENT		      ((RAW_DATA_PRESENT)0x4000)

#define RAW_TRANSDUCER_BUTTONS_PRESENT	    ((RAW_DATA_PRESENT)0x8000)

 

typedef struct tagRawTabletData

{

		tagRawTabletData()

				: fRawDataPresent(0)

				, wTransducerIndex(0)

				, bInProx(0)

				, wType(0)

				, wTransducerExtendedID(0)

				, dwTransducerSerialNumber(0)

				, dwX(0)

				, dwY(0)

				, transducerButtons(0)

				, tabletButtons(0)

				, wPressure(0)

				, nXTilt(0)

				, nYTilt(0)

				, nRoller(0)

				, wRotation(0)

				, wAnalogue1(0)

				, wAnalogue2(0)

				, wAnalogue3(0)

				, height(0)

		{ }

 

// bit field for what valid data items are contained in returned

// structure

		RAW_DATA_PRESENT fRawDataPresent;

 

// Index of the transducer in the tablet's transducer container

		UINT16 wTransducerIndex;

 

// FALSE if EOut

		UINT16 bInProx;

 

		UINT16 wType;

 

// also called transducer ID

		UINT32 wTransducerExtendedID;

		UINT32 dwTransducerSerialNumber;

 

		UINT32 dwX;

		UINT32 dwY;

 

		UINT32 transducerButtons;

		UINT32 tabletButtons;

 

		UINT16 wPressure;

 

		SINT16 nXTilt;

		SINT16 nYTilt;

 

		SINT16 nRoller;

 

		UINT16 wRotation;

 

		UINT16 wAnalogue1;

		UINT16 wAnalogue2;

		UINT16 wAnalogue3;

 

		UINT8     height;

 

} RAW_TABLET_DATA;

 

 

 

// used to get specific chunk of raw data

typedef enum ETabletDataElement

{

		EWholePacket,

		EDataPresentElement,

		ETransducerIndexElement,

		EProximityElement,

		ETransducerExtIDElement,

		EtTransducerSNElement,

		EXPosElement,

		EYPosElement,

		EDeprecatedButtonStateElement,

		EtPressureElement,

		EtXTiltElement,

		EYTiltElement,

		EWheelPosElement,

		ERotationElement,

		EAnalog1Element,

		EAnalog2Element,

		EAnalog3Element,

		EHeightElement,

		ECoordElement,

		ETransducerButtonsElement,

		ETabletButtonsElement,

		EtTransducerTypeElement,

		MAXTABLETDATAELEMENT

 

} ETabletDataElement;

 

 

typedef UINT32 APPIDENTIFIER;

#define DEFAULT_APPLICATION ((APPIDENTIFIER) 0)

#define INVALID_APPLICATION ((APPIDENTIFIER) -1)

 

#define    SYNCH_BIT									    ((UINT8)0x80)

 

typedef UINT16      BAUD_RATE;

 

#define BAUD1200		 ((BAUD_RATE)1200)

#define BAUD9600		 ((BAUD_RATE)9600)

#define BAUD19200			       ((BAUD_RATE)19200)

#define BAUD38400			       ((BAUD_RATE)38400)

 

// usehid states.

// duplicated in "wacomreports.h" so it can be shared with the PC kernel drivers.

#define NOHIDPEN						0	      // Normal tablet data (external and non-HID)

#define REALHIDPEN			    1	      // TabletPC Data

#define VHIDPEN				   2	      // External tablet data sent to system as HID pen data

#define ALLINTEGRATED    4	      // Treat all tablets as integrated

#define CMDHIDPEN					     8	      // Data comes from ISD but is treated normally (non-HID)

 

typedef enum EControlPanelSelectTab

{

		// Functions Tabs

		ECPLSelectTabTouchStrip,

		ECPLSelectTabExpressKeys,

		ECPLSelectTabRadialMenu,

		ECPLSelectTabDisplayToggle,

 

		// Stylus Tabs

		ECPLSelectTabPen,

		ECPLSelectTabEraser,

		ECPLSelectTabCalibrate,

 

		// Other Tabs

		ECPLSelectTabTouchRing,

		ECPLSelectTabTouchStripModifiers,

		ECPLSelectTabMapping,

		ECPLSelectTabStylus,

		ECPLSelectTabMenu,

		ECPLSelectTabPopup,

		ECPLSelectTabTouchPrefs

 

} EControlPanelSelectTab;

 

// Tab types used to support selection when CPL opens.

typedef enum ETabViewType

{

		ETabViewTypeUnknown = 0, // must be first

		ETabViewTypeRadialMenu,

		ETabViewTypeDisplayToggle,

		ETabViewTypeTouchRing,

		ETabViewTypeTouchStrip,

		ETabViewTypeTouchStripModifiers,

		ETabViewTypeExpressKeys,

		ETabViewTypePen,

		ETabViewTypeEraser,

		ETabViewTypeMapping,

		ETabViewTypeCalibrate,

		ETabViewTypeStylus,

		ETabViewTypeMenu,

		ETabViewTypePopup,

		ETabViewTypeWireless,

		ETabViewTypeTouchOptions,

		ETabViewTypeTouchMyGestures,

 

		ETabViewTypeEndOfTheLine						// must be last

} ETabViewType;

 

// Common-platform plugin defines.

#define WACOM_TABLET_PLUGIN_PORT_NAME			     "WacomTabletPlugin"

 

////////// NOTE - THIS SECTION MUST BE AFTER ALL DEFINITIONS /////////////////

//////////////////////////////////////////////////////////////////////////////

// Symbols representing different OSes

//

//	      PLATFORM_MACOSX

//	      PLATFORM_MACOSX

// PLATFORM_WIN

 

#if defined(PLATFORM_WIN)

 

// multiple inheritance causes 1000+ warnings at warning level 3

#pragma warning( disable : 4250 )

// conditional expression is constant (WACOM_ASSERT)

#pragma warning( disable : 4127 )

// assignment to greater sized type

#pragma warning( disable : 4244 )

// unrefed inline removed

#pragma warning( disable : 4514 )

// function not inlined as requested

#pragma warning( disable : 4710 )

 

typedef void (*SerialIOCallback) (UINT8 *, UINT8);

 

struct SContextData

{

		UINT16 wOptions;

		UINT16 wMsgBase;

		UINT16 pad1;

		UINT16 pad2;

		WACOMPTR hWnd;

#if !defined(WIN64)

		UINT32 pad3;

#endif

};

#include "wac_nt.h"

 

// Compile-time debugging macros for Windows only.

// Use with #pragma message (__LOC__ "warning message")

#define __STR2__(x) #x

#define __STR1__(x) __STR2__(x)

#define __LOC__ __FILE__ "("__STR1__(__LINE__)") : WARNING: "

#define __LOC2__ __FILE__ "("__STR1__(__LINE__)") : INFO: "

#define __LOC3__ __FILE__ "("__STR1__(__LINE__)") : TODO: "

 

// Shortcuts

// Eg: PWARN("THIS CODE NEEDS TO BE REVIEWED!")

// Eg: PINFO("Ignore compiler warnings")

// Eg: PTODO("Not implemented yet")

#define PWARN(msg)	     __pragma(message(__LOC__ msg))

#define PINFO(msg)		__pragma(message(__LOC2__ msg))

#define PTODO(msg)	      __pragma(message(__LOC3__ msg))

 

#else

// non-Windows stubs

#define PWARN(msg)

#define PINFO(msg)

#define PTODO(msg)

 

#endif // PLATFORM_WIN

 

#if defined(PLATFORM_MACOSX)       //	      {

typedef void (*SerialIOCallback) (UINT8 *, UINT8);

 

struct SContextData

{

		UINT32 nothingForNow;

};

#if !defined ( NO_DRIVER ) 

		#include "wac_macx.h"

#elif !defined( PLATFORM_MACOSX_PLUGIN )

		#include "wac_macx.h"

#endif

 

#endif										      //	      }

////////// NOTE - THIS SECTION MUST BE AFTER ALL DEFINITIONS /////////////////

 

 


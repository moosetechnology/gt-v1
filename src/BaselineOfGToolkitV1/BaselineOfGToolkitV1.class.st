Class {
	#name : #BaselineOfGToolkitV1,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitV1
}

{ #category : #baselines }
BaselineOfGToolkitV1 >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			package: 'GT-Coder' with: [
				spec requires: #( 'Glamour') ];
			package: 'GT-DebuggerExtensions' with: [ 
				spec requires: #(GTDebugger) ];
			package: 'GT-GlamourDebugger' with: [
				spec requires: #( 'GTDebugger' 'Roassal2' 'GT-DebuggerExtensions') ];
			package: 'GT-PetitParserDebugger' with: [
				spec requires: #( 'GTDebugger' 'PetitParser' 'GT-DebuggerExtensions') ];
			package: 'GT-Debugger-EventRecorder' with: [ 
				spec requires: #(GTDebugger GTEventRecorder) ];
			package: 'GT-Window-EventRecorder' with: [ 
				spec requires: #(GTEventRecorder) ];
			package: 'GT-Setup';
			package: 'GT-Tools' with: [
				spec requires: #( 'Glamour') ];
			package: 'Glamour-Morphic-Theme' with: [
				spec repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ];
			package: 'GT-Tests-Release'.
			
		spec
			project: 'PetitParser' with: [
				spec
					versionString: #'development';
					className: 'ConfigurationOfPetitParser';
					repository: 'http://www.smalltalkhub.com/mc/Moose/PetitParser/main' ];
			baseline: 'Roassal2' with: [ 
				spec repository: 'github://ObjectProfile/Roassal2/src' ];
			baseline: 'Glamour' with: [ 
				spec repository: 'github://moosetechnology/Glamour/src' ];
			baseline: 'GTDebugger' with: [ 
				spec repository: 'github://moosetechnology/gt-v1/src' ];
			baseline: 'AnnouncerCentricDebugger' with: [ 
				spec repository: 'github://moosetechnology/AnnouncerCentricDebugger/src' ];
			baseline: 'GTInspector' with: [ 
				spec repository: 'github://moosetechnology/gt-v1/src' ];
			baseline: 'GTPlayground' with: [ 
				spec repository: 'github://moosetechnology/gt-v1/src' ]; 
			baseline: 'GTSpotter' with: [ 
				spec repository: 'github://moosetechnology/gt-v1/src' ]; 
			baseline: 'GTEventRecorder' with: [ 
				spec repository: 'github://moosetechnology/gt-v1/src' ];
			baseline: 'Beacon' with: [ 
				spec repository: 'github://pharo-project/pharo-beacon/repository' ]  ]
]

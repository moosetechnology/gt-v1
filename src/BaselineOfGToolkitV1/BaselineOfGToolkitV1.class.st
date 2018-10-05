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
			project: 'Roassal2' with: [
				spec
					className: 'ConfigurationOfRoassal2';
					file: 'ConfigurationOfRoassal2';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main' ];
			baseline: 'Glamour' with: [ 
				spec repository: 'github://moosetechnology/Glamour:pharo6/src' ];
			baseline: 'GTDebugger' with: [ 
				spec repository: 'github://moosetechnology/gt-v1:pharo6/src' ];
			baseline: 'AnnouncerCentricDebugger' with: [ 
				spec repository: 'github://moosetechnology/AnnouncerCentricDebugger:pharo6/src' ];
			baseline: 'GTInspector' with: [ 
				spec repository: 'github://moosetechnology/gt-v1:pharo6/src' ];
			baseline: 'GTPlayground' with: [ 
				spec repository: 'github://moosetechnology/gt-v1:pharo6/src' ]; 
			baseline: 'GTSpotter' with: [ 
				spec repository: 'github://moosetechnology/gt-v1:pharo6/src' ]; 
			baseline: 'GTEventRecorder' with: [ 
				spec repository: 'github://moosetechnology/gt-v1:pharo6/src' ];
			baseline: 'Beacon' with: [ 
				spec repository: 'github://pharo-project/pharo-beacon/repository' ]  ]
]

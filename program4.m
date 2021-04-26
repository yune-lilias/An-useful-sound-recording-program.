% program4.m
  %
  % Author: Yuhan Yang
  % Account: yyang49
  % CSc 4630/6630 Program (this program number)
  %
  % Due date: 04/25/2021
  %
  % Description:
  % An useful sound recording program.
  %
  % Input:
  % Recorded sound.
  %
  % Output:
  % "prog4sound.ogg", which is the sound file after cutting
  %
  % Usage:
  % Click record to record
  % Click stop to stop record and view sound plot
  % Then click record to re-record or "add channel" to record for 2nd
  % channel
  % Click select and click on two points inside corresponding plot
  % After select an area, click cut to cut that channel
  % Click save to save file.
  % Notice: before of play or save file, the value of sound vector is 100
  % times larger in order to make it loud enough to be heard.




function varargout = program4(varargin)
% PROGRAM4 MATLAB code for program4.fig
%      PROGRAM4, by itself, creates a new PROGRAM4 or raises the existing
%      singleton*.
%
%      H = PROGRAM4 returns the handle to a new PROGRAM4 or the handle to
%      the existing singleton*.
%
%      PROGRAM4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROGRAM4.M with the given input arguments.
%
%      PROGRAM4('Property','Value',...) creates a new PROGRAM4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before program4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to program4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help program4

% Last Modified by GUIDE v2.5 20-Apr-2021 20:42:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @program4_OpeningFcn, ...
                   'gui_OutputFcn',  @program4_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before program4 is made visible.
function program4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to program4 (see VARARGIN)

% Choose default command line output for program4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes program4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = program4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in stop.
function record_Callback(hObject, eventdata, handles)
warning('off','all');
disp("Recording");
try
    clear sound;
catch exception
end
handles.pic1.Visible = 'off';
handles.pic2.Visible = 'off';
handles.pic.Visible = 'on';
handles.channel1.Visible = 'off';
handles.channel2.Visible = 'off';
handles.select.String = 'select';
global audio fs channels;
handles.channel.Visible = 'off';
handles.selectnew.Visible = 'off';
channels = 1;
fs = 8000;
cla(handles.pic);
audio = audiorecorder(fs, 16, 1);
record(audio);
handles.label.String = 'Now Recording';
handles.label.Visible = 'on';
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
global audio audioData channels preaudioData;
disp("Stop recording");
try
    clear sound;
catch exception
end
cla(handles.pic);
cla(handles.pic1);
cla(handles.pic2);
stop(audio);
handles.label.Visible = 'off';
if(channels == 1)
audioData = getaudiodata(audio);
plot(handles.pic,audioData);
hold(handles.pic,'on');
handles.channel.Visible = 'on';
axis(handles.pic,[0 length(audioData) 1.1*min(audioData) 1.1*max(audioData)])
handles.channel1.Visible = 'on';
handles.channel2.Visible = 'on';
else
preaudioData = audioData;
audioData = getaudiodata(audio);   
handles.selectnew.Visible = 'on';
handles.select.String = 'select 2nd';
plot(handles.pic2,audioData);
hold(handles.pic2,'on');
axis(handles.pic2,[0 length(audioData) 1.1*min(audioData) 1.1*max(audioData)])
plot(handles.pic1,preaudioData);
hold(handles.pic1,'on');
axis(handles.pic1,[0 length(preaudioData) 1.1*min(preaudioData) 1.1*max(preaudioData)])
end
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
disp("Playing");
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audioData fs channels preaudioData;
try
    clear sound;
catch exception
end
if(channels == 1)
sound(audioData, fs);
else
    i = min(length(audioData),length(preaudioData));
    sound([audioData(1:i)*100 preaudioData(1:i)*100],fs);
end


% --- Executes on button press in select.
function select_Callback(hObject, eventdata, handles)
% hObject    handle to select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audioData x y channels pos h1 h2 h3 h4;
try
    clear sound;
catch exception
end
handles.channel1.Visible = 'off';
handles.channel2.Visible = 'off';
handles.channel3.Visible = 'off';
if(channels == 1)
    disp("Selecting");
set(gcf,'CurrentAxes',handles.pic);
try
 delete(h1);
 delete(h2);
 delete(h3);
 delete(h4);
catch exception
end
handles.select1.Visible = 'on';
handles.select2.Visible = 'on';
[x y] = ginput(2)
handles.select1.Visible = 'off';
handles.select2.Visible = 'off';
if(x(1) >= length(audioData))
    x(1) = length(audioData);
elseif(x(1) <= 0)
    x(1) = 0;
end
if(x(2) >= length(audioData))
    x(2) = length(audioData);
elseif(x(2) <= 0)
    x(2) = 0;
end
if(y(1) >= 1.1*max(audioData))
    y(1) = 1.1*max(audioData);
elseif(y(1) <= 1.1*min(audioData))
    y(1) = 1.1*min(audioData);
end
if(y(2) >= 1.1*max(audioData))
    y(2) = 1.1*max(audioData);
elseif(y(2) <= 1.1*min(audioData))
    y(2) = 1.1*min(audioData);
end


h1 = plot(handles.pic,[x(1),x(1)],[y(1),y(2)],'r*-');
h2 = plot(handles.pic,[x(2),x(2)],[y(1),y(2)],'r*-');
h3 = plot(handles.pic,[x(1),x(2)],[y(1),y(1)],'r*-');
h4 = plot(handles.pic,[x(1),x(2)],[y(2),y(2)],'r*-');
else
     disp("Selecting 2nd channel");
    pos = 'pic2';
set(gcf,'CurrentAxes',handles.pic2);
try
 delete(h1);
 delete(h2);
 delete(h3);
 delete(h4);
catch exception
end
handles.select1.Visible = 'on';
handles.select2.Visible = 'on';
[x y] = ginput(2)
handles.select1.Visible = 'off';
handles.select2.Visible = 'off';
if(x(1) >= length(audioData))
    x(1) = length(audioData);
elseif(x(1) <= 0)
    x(1) = 0;
end
if(x(2) >= length(audioData))
    x(2) = length(audioData);
elseif(x(2) <= 0)
    x(2) = 0;
end
if(y(1) >= 1.1*max(audioData))
    y(1) = 1.1*max(audioData);
elseif(y(1) <= 1.1*min(audioData))
    y(1) = 1.1*min(audioData);
end
if(y(2) >= 1.1*max(audioData))
    y(2) = 1.1*max(audioData);
elseif(y(2) <= 1.1*min(audioData))
    y(2) = 1.1*min(audioData);
end

h1 = plot(handles.pic2,[x(1),x(1)],[y(1),y(2)],'r*-');
h2 = plot(handles.pic2,[x(2),x(2)],[y(1),y(2)],'r*-');
h3 = plot(handles.pic2,[x(1),x(2)],[y(1),y(1)],'r*-');
h4 = plot(handles.pic2,[x(1),x(2)],[y(2),y(2)],'r*-');  
    
    
end

% --- Executes on button press in selectnew.
function selectnew_Callback(hObject, eventdata, handles)
% hObject    handle to selectnew (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x y preaudioData pos h1 h2 h3 h4;
 disp("Selecting 1st channel");
try
    clear sound;
catch exception
end
audioData = preaudioData;
 pos = 'pic1';
set(gcf,'CurrentAxes',handles.pic1);
try
 delete(h1);
 delete(h2);
 delete(h3);
 delete(h4);
catch exception
end
handles.select1.Visible = 'on';
handles.select2.Visible = 'on';
[x y] = ginput(2)
handles.select1.Visible = 'off';
handles.select2.Visible = 'off';
if(x(1) >= length(audioData))
    x(1) = length(audioData);
elseif(x(1) <= 0)
    x(1) = 0;
end
if(x(2) >= length(audioData))
    x(2) = length(audioData);
elseif(x(2) <= 0)
    x(2) = 0;
end
if(y(1) >= 1.1*max(audioData))
    y(1) = 1.1*max(audioData);
elseif(y(1) <= 1.1*min(audioData))
    y(1) = 1.1*min(audioData);
end
if(y(2) >= 1.1*max(audioData))
    y(2) = 1.1*max(audioData);
elseif(y(2) <= 1.1*min(audioData))
    y(2) = 1.1*min(audioData);
end

h1 = plot(handles.pic1,[x(1),x(1)],[y(1),y(2)],'r*-');
h2 = plot(handles.pic1,[x(2),x(2)],[y(1),y(2)],'r*-');
h3 = plot(handles.pic1,[x(1),x(2)],[y(1),y(1)],'r*-');
h4 = plot(handles.pic1,[x(1),x(2)],[y(2),y(2)],'r*-');  




% --- Executes on button press in cut.
function cut_Callback(hObject, eventdata, handles)
% hObject    handle to cut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    clear sound;
catch exception
end
global x y channels pos;
ymax = max(y);
ymin = min(y);
xmax = max(x);
xmin = min(x);
if(channels == 1)
     disp("Cutting");
    global audioData; 
audioData = audioData(xmin:xmax);
audioData = (audioData > ymax)*ymax +(audioData <= ymax).*audioData;
audioData = (audioData < ymin)*ymin +(audioData >= ymin).*audioData;
cla(handles.pic);
plot(handles.pic,audioData);
hold on;
axis(handles.pic,[0 length(audioData) 1.1*min(audioData) 1.1*max(audioData)])
y(1) = ymax;
y(2) = ymin;
x(1) = 0;
x(2) = (xmax - xmin);
else
    if(pos == 'pic1')
         disp("Cutting 1st channel");
        global preaudioData;
        preaudioData = preaudioData(xmin:xmax);
        preaudioData = (preaudioData > ymax)*ymax +(preaudioData <= ymax).*preaudioData;
        preaudioData = (preaudioData < ymin)*ymin +(preaudioData >= ymin).*preaudioData;
        cla(handles.pic1);
plot(handles.pic1,preaudioData);
hold on;
axis(handles.pic1,[0 length(preaudioData) 1.1*min(preaudioData) 1.1*max(preaudioData)])
y(1) = ymax;
y(2) = ymin;
x(1) = 0;
x(2) = (xmax - xmin);
    else
        disp("Cutting 2nd channel");
        global audioData;
        audioData = audioData(xmin:xmax);
        audioData = (audioData > ymax)*ymax +(audioData <= ymax).*audioData;
        audioData = (audioData < ymin)*ymin +(audioData >= ymin).*audioData;
        cla(handles.pic2);
plot(handles.pic2,audioData);
hold on;
axis(handles.pic2,[0 length(audioData) 1.1*min(audioData) 1.1*max(audioData)])
y(1) = ymax;
y(2) = ymin;
x(1) = 0;
x(2) = (xmax - xmin);
    end
end
% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
global channels audioData preaudioData;
 disp("saving");
try
    clear sound;
catch exception
end
global fs;
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(channels == 1)
    audiowrite('prog4sound.ogg', audioData*10, fs);
else
    i = min(length(audioData),length(preaudioData));
    k = [audioData(1:i)*10 preaudioData(1:i)*10];
    audiowrite('prog4sound.ogg', k, fs);
end




% --- Executes on button press in channel.
function channel_Callback(hObject, eventdata, handles)
 disp("Adding new channel");
try
    clear sound;
catch exception
end
% hObject    handle to channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global channels audio audioData preaudioData fs;
if(channels == 1)
channels = 2;
handles.pic1.Visible = 'on';
handles.pic2.Visible = 'on';
handles.pic.Visible = 'off';
else
    channels = 2;
    preaudioData = audioData;
end
handles.channel1.Visible = 'off';
handles.channel2.Visible = 'off';
handles.channel3.Visible = 'on';
cla(handles.pic);
audio = audiorecorder(fs, 16, 1);
record(audio);
handles.label.String = 'Now Recording';
handles.label.Visible = 'on';

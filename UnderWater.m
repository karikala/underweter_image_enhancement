function varargout = UnderWater(varargin)
% UNDERWATER MATLAB code for UnderWater.fig
%      UNDERWATER, by itself, creates a new UNDERWATER or raises the existing
%      singleton*.
%
%      H = UNDERWATER returns the handle to a new UNDERWATER or the handle to
%      the existing singleton*.
%
%      UNDERWATER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNDERWATER.M with the given input arguments.
%
%      UNDERWATER('Property','Value',...) creates a new UNDERWATER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before UnderWater_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to UnderWater_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help UnderWater

% Last Modified by GUIDE v2.5 25-Apr-2021 03:40:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UnderWater_OpeningFcn, ...
                   'gui_OutputFcn',  @UnderWater_OutputFcn, ...
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


% --- Executes just before UnderWater is made visible.
function UnderWater_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to UnderWater (see VARARGIN)

% Choose default command line output for UnderWater
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes UnderWater wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = UnderWater_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Image input
% We take a RGB image as input and convert it to grayscale and store it in
% another variable, so we can get the mean luminance.

 
    [filename, pathname] = uigetfile('*.*', 'Pick a MATLAB code file');
    if isequal(filename,0) || isequal(pathname,0)
       disp('User pressed cancel')
    else
       filename = imread(strcat(pathname, filename));
    end
rgbImage=im2double(filename);
axes(handles.axes1)
imshow(rgbImage)
% grayImage = rgb2gray(rgbImage); 
%% White Balancing
% Extract the individual red, green, and blue color channels.
x =434;
y= 939;
gray_val = impixel(rgbImage,x,y);
drawpoint('position',[x,y],'color','g');
rgbImage_white_balance = chromadapt(rgbImage,gray_val);
axes(handles.axes2)
imshow(rgbImage_white_balance)
title('After White balance');

%% Gamma Correction and sharpening
I = imadjust(rgbImage_white_balance,[],[],0.5);
            
J=(rgbImage_white_balance+(rgbImage_white_balance-imgaussfilt(rgbImage_white_balance)));

% figure('Name','Step I-III');
% subplot(221);
% imshow(rgbImage);
% title('Original Image');
% 
% subplot(222);
% imshow(rgbImage_white_balance);
% title('I. White Balance');
% 
% subplot(223);
% imshow(I);
% title('II. Gamma Corrected');
% subplot(224);
% imshow(J);
% title('III. Sharpened');

% %% Image Fusion using wavelet transform
% 
% XFUS = wfusimg(I,J,'sym4',3,'max','max');
% 
% figure('Name','Final Comparison');
% subplot(121);
% imshow(rgbImage);
% title('Original');
% 
% subplot(122);
% r = histeq(XFUS);
% imshow((histeq(XFUS)));
% title('IV. Wavelet fusion');
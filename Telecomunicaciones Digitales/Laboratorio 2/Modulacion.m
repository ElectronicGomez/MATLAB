function varargout = Modulacion(varargin)
%MODULACION M-file for Modulacion.fig
%      MODULACION, by itself, creates a new MODULACION or raises the existing
%      singleton*.
%
%      H = MODULACION returns the handle to a new MODULACION or the handle to
%      the existing singleton*.
%
%      MODULACION('Property','Value',...) creates a new MODULACION using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to Modulacion_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      MODULACION('CALLBACK') and MODULACION('CALLBACK',hObject,...) call the
%      local function named CALLBACK in MODULACION.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Modulacion

% Last Modified by GUIDE v2.5 15-May-2019 00:00:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Modulacion_OpeningFcn, ...
                   'gui_OutputFcn',  @Modulacion_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before Modulacion is made visible.
function Modulacion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

global aniM; global aniAxe; global bitsM; global bits; global t; 
global div; global ax_bits; global Datos_estado; global continua;
global tb_ASK; global tb_PSK; global tb_FSK; global tb_QAM;
global aniAxeM; global aniB; global aniBit; global Estado_Grafico;
tb_ASK = []; tb_PSK = []; tb_FSK = []; tb_QAM = [];
continua = 0;
Datos_estado = 0; Estado_Grafico = 0;
ax_bits = 0;
aniAxe = 0; aniB = 0; aniBit = 0;
aniAxeM = 0;
t = 0;
aniM = 0;
bitsM = '';
bits = [];
div = [0 1];
%get(handles.axes_bits);
set(handles.axes_bits,'XColor',[1 1 1]);
set(handles.axes_bits,'YColor',[0.6353 0.0784 0.1843]);
set(handles.axes_bits,'Color',[0.6353 0.0784 0.1843]);
set(handles.radbut_Carson,'Value',1);
set(handles.RadButFilCorr,'Value',1);
set(handles.SNR,'String',5);
% Choose default command line output for Modulacion
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Modulacion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Modulacion_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in opciones.
function opciones_Callback(hObject, eventdata, handles)
% hObject    handle to opciones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns opciones contents as cell array
%        contents{get(hObject,'Value')} returns selected item from opciones
global Opc;
Opc = get(handles.opciones,'Value');
switch Opc
    case 1
        set(handles.N,'Enable','on');
        set(handles.text_N,'String','N');
        set(handles.N,'String',0);
        set(handles.uipanel3,'Title','Datos Generales');
        set(handles.teta,'String',0)
    case 2
        set(handles.N,'Enable','on');
        set(handles.text_N,'String','ASK');
        set(handles.N,'String',0);
        set(handles.uipanel3,'Title','Datos ASK | 0=On_Off / 1=Polar');
        set(handles.teta,'String',0)
    case 3
        set(handles.N,'Enable','on');
        set(handles.text_N,'String','N');
        set(handles.N,'String',0);
        set(handles.uipanel3,'Title','Datos PSK | inicio: 0=0 rad | 1=pi/4');
        set(handles.teta,'String',90)
    case 4
        set(handles.N,'Enable','on');
        set(handles.text_N,'String','N');
        set(handles.N,'String',1);
        set(handles.uipanel3,'Title','Datos FSK');
        set(handles.teta,'String',0)
    case 5
        set(handles.N,'String','');
        set(handles.N,'Enable','off');
        set(handles.text_N,'String',' ');
        set(handles.uipanel3,'Title','Datos QAM');
        set(handles.teta,'String',0)
end

% --- Executes during object creation, after setting all properties.
function opciones_CreateFcn(hObject, eventdata, handles)
% hObject    handle to opciones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ac_Callback(hObject, eventdata, handles)
% hObject    handle to Ac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ac as text
%        str2double(get(hObject,'String')) returns contents of Ac as a double


% --- Executes during object creation, after setting all properties.
function Ac_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function teta_Callback(hObject, eventdata, handles)
% hObject    handle to teta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of teta as text
%        str2double(get(hObject,'String')) returns contents of teta as a double


% --- Executes during object creation, after setting all properties.
function teta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to teta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fb_Callback(hObject, eventdata, handles)
% hObject    handle to fb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fb as text
%        str2double(get(hObject,'String')) returns contents of fb as a double


% --- Executes during object creation, after setting all properties.
function fb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fc_Callback(hObject, eventdata, handles)
% hObject    handle to fc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fc as text
%        str2double(get(hObject,'String')) returns contents of fc as a double


% --- Executes during object creation, after setting all properties.
function fc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function N_Callback(hObject, eventdata, handles)
% hObject    handle to N (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of N as text
%        str2double(get(hObject,'String')) returns contents of N as a double


% --- Executes during object creation, after setting all properties.
function N_CreateFcn(hObject, eventdata, handles)
% hObject    handle to N (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function M_Callback(hObject, eventdata, handles)
% hObject    handle to M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of M as text
%        str2double(get(hObject,'String')) returns contents of M as a double


% --- Executes during object creation, after setting all properties.
function M_CreateFcn(hObject, eventdata, handles)
% hObject    handle to M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radbut_Normal.
function radbut_Normal_Callback(hObject, eventdata, handles)
% hObject    handle to radbut_Normal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radbut_Normal


% --- Executes on button press in radbut_Gray.
function radbut_Gray_Callback(hObject, eventdata, handles)
% hObject    handle to radbut_Gray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radbut_Gray


% --- Executes on button press in but_uno.
function but_uno_Callback(hObject, eventdata, handles)
% hObject    handle to but_uno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global bitsM; global bits; global t; global div; global ax_bits;
amp = [0.75 0.75];
tiempo = [t t+1];
tiempoDiv = [t+1 t+1];
t = t+1;
axes(handles.axes_bits)
plot(tiempo,amp,'g','LineWidth',2); hold on;
plot(tiempoDiv,div,'c:','LineWidth',2); hold on;
set(handles.axes_bits,'XColor',[1 1 1]);
set(handles.axes_bits,'YColor',[0.6353 0.0784 0.1843]);
set(handles.axes_bits,'Color',[0.6353 0.0784 0.1843]);
if t > 8
    ax_bits = ax_bits+1;
end
axis([ax_bits 10+ax_bits 0 1]);
bitsM = [bitsM num2str(get(hObject,'Value'))];
set(handles.text_mosbits,'String',bitsM);
bits = [bits 1];
numeroBitsG = length(bits);
set(handles.text_numbits,'String',num2str(numeroBitsG));
%set(handles.axes_bits,'XColor',[1 1 1])

% --- Executes on button press in but_cero.
function but_cero_Callback(hObject, eventdata, handles)
% hObject    handle to but_cero (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global bitsM; global bits; global t; global div; global ax_bits;
amp = [0.25 0.25];
tiempo = [t t+1];
tiempoDiv = [t+1 t+1];
t = t+1;
axes(handles.axes_bits)
plot(tiempo,amp,'g','LineWidth',2); hold on;
plot(tiempoDiv,div,'c:','LineWidth',2); hold on;
set(handles.axes_bits,'XColor',[1 1 1]);
set(handles.axes_bits,'YColor',[0.6353 0.0784 0.1843]);
set(handles.axes_bits,'Color',[0.6353 0.0784 0.1843]);
if t > 8
    ax_bits = ax_bits+1;
end
axis([ax_bits 10+ax_bits 0 1]);
bitsM = [bitsM num2str(0)];
set(handles.text_mosbits,'String',bitsM);
bits = [bits 0];
numeroBitsG = length(bits);
set(handles.text_numbits,'String',num2str(numeroBitsG));

% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton2


% --- Executes on button press in tog_Animacion.
function tog_Animacion_Callback(hObject, eventdata, handles)
% hObject    handle to tog_Animacion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tog_Animacion
global aniM, global aniAxe, global aniAxeM, global Ac, global Opc; global margen;
global precont; global continua; global aniB; global aniBit; global Estado_Grafico;
global mod_ASK; global tb_ASK; global ts_ASK;
global mod_PSK; global tb_PSK; global ts_PSK;
global mod_FSK; global tb_FSK; global ts_FSK;
%global mod_QAM; global tb_QAM; global ts_QAM;
global demo_ASK; global demo_PSK; global demo_FSK; global bit;
global demoBits_ASK; global demoBits_PSK; global demoBits_FSK;
global mod_ASK_e; global mod_PSK_e; global mod_FSK_e; global mod_QAM_e;
if Estado_Grafico == 1
    axes(handles.axes4); cla;
    axes(handles.axes3); cla;
    axes(handles.axes5); cla;
    axes(handles.axes6); cla;
    axes(handles.axes4); cla;
    set(handles.axes6,'Color',[0.6353 0.0784 0.1843]);
    set(handles.axes6,'XColor',[1 1 1]);
    set(handles.axes6,'YColor',[0.6353 0.0784 0.1843]);
    Estado_Grafico = 0;
end
if get(hObject,'Value')
    set(hObject,'String','Parar')
else
    set(hObject,'String','Animacion')
end
switch Opc
%% ASK
    case 2
        while get(hObject,'Value')
            while get(hObject,'Value') && tb_ASK(precont) > aniAxe
                axes(handles.axes3)
                set(handles.axes3,'XColor',[1 1 1]);
                set(handles.axes3,'YColor',[1 1 1]);
                set(handles.axes3,'Color',[0.6353 0.0784 0.1843]);
                axis([-10+aniAxe 0+aniAxe -Ac*1.25 Ac*1.25]);
                if get(handles.tog_Ruido,'Value')
                    plot(tb_ASK(aniM+1:aniM+40),mod_ASK_e(aniM+1:aniM+40),'b'); hold on;
                else
                    plot(tb_ASK(aniM+1:aniM+40),mod_ASK(aniM+1:aniM+40),'b'); hold on;
                end
                axes(handles.axes5)
                set(handles.axes5,'XColor',[1 1 1]);
                set(handles.axes5,'YColor',[1 1 1]);
                set(handles.axes5,'Color',[0.6353 0.0784 0.1843]);
                axis([-10+aniAxe 0+aniAxe -Ac*1.25 Ac*1.25]);
                plot(tb_ASK(aniM+1:aniM+40),mod_ASK(aniM+1:aniM+40),'b'); hold on;

                axes(handles.axes4)
                set(handles.axes4,'XColor',[1 1 1]);
                set(handles.axes4,'YColor',[1 1 1]);
                set(handles.axes4,'Color',[0.6353 0.0784 0.1843]);
                axis([+aniAxeM 10+aniAxeM -2.25*Ac 2.25*Ac]);
                if aniAxe >= 10
                    plot(tb_ASK(aniB+1:aniB+40),demo_ASK(aniB+1:aniB+40),'b'); hold on;
                    if aniB < length(tb_ASK)-40
                        aniB = aniB+40;
                    end
                    if aniAxe >= 11 && aniBit < length(tb_ASK)-40
                        plot(tb_ASK(aniBit+1:aniBit+40)+ts_ASK,demoBits_ASK(aniBit+1:aniBit+40),'g','LineWidth',2); xlabel('segundos'); ylabel('Voltaje'); 
                        axes(handles.axes6)
                        axis([aniAxeM 10+aniAxeM -0.25 Ac+0.25]);
                        plot(tb_ASK(aniBit+1:aniBit+40)+ts_ASK,bit(aniBit+1:aniBit+40),'g','LineWidth',2); hold on;  
                        ylabel('Voltaje'); 
                        set(handles.axes6,'XColor',[1 1 1]);
                        set(handles.axes6,'YColor',[0.6353 0.0784 0.1843]);
                        set(handles.axes6,'Color',[0.6353 0.0784 0.1843]);
                        aniBit = aniBit+40;
                    end
                end
                if aniAxe >= 20
                    aniAxeM = aniAxeM+40*0.001;
                end
                aniM = aniM+40;
                aniAxe = aniAxe+40*0.001;
                pause(0.001);
            end
            while tb_ASK(precont) <= aniAxe && tb_ASK(continua)+margen > aniAxe && get(hObject,'Value')
                axes(handles.axes3)
                set(handles.axes3,'XColor',[1 1 1]);
                set(handles.axes3,'YColor',[1 1 1]);
                set(handles.axes3,'Color',[0.6353 0.0784 0.1843]);
                axis([-10+aniAxe 0+aniAxe -Ac*1.25 Ac*1.25]);
                axes(handles.axes5)
                set(handles.axes5,'XColor',[1 1 1]);
                set(handles.axes5,'YColor',[1 1 1]);
                set(handles.axes5,'Color',[0.6353 0.0784 0.1843]);
                axis([-10+aniAxe 0+aniAxe -Ac*1.25 Ac*1.25]);
                
                axes(handles.axes4)
                set(handles.axes4,'XColor',[1 1 1]);
                set(handles.axes4,'YColor',[1 1 1]);
                set(handles.axes4,'Color',[0.6353 0.0784 0.1843]);
                axis([aniAxeM 10+aniAxeM -2.25*Ac 2.25*Ac]);
                if aniAxe >= 10  
                    plot(tb_ASK(aniB+1:aniB+40),demo_ASK(aniB+1:aniB+40),'b'); hold on;
                    if aniB < length(tb_ASK)-40
                        aniB = aniB+40;
                    end
                    if aniAxe >= 11 && aniBit < length(tb_ASK)-40
                        plot(tb_ASK(aniBit+1:aniBit+40)+ts_ASK,demoBits_ASK(aniBit+1:aniBit+40),'g','LineWidth',2); xlabel('segundos'); ylabel('Voltaje'); 
                        axes(handles.axes6)
                        axis([aniAxeM 10+aniAxeM -0.25 Ac+0.25]);
                        plot(tb_ASK(aniBit+1:aniBit+40)+ts_ASK,bit(aniBit+1:aniBit+40),'g','LineWidth',2); hold on;  
                        ylabel('Voltaje'); 
                        set(handles.axes6,'XColor',[1 1 1]);
                        set(handles.axes6,'YColor',[0.6353 0.0784 0.1843]);
                        set(handles.axes6,'Color',[0.6353 0.0784 0.1843]);
                        aniBit = aniBit+40;                       
                    end
                end
                if aniAxe >= 20
                    aniAxeM = aniAxeM+40*0.001;
                end
                %plot(aniAxe:0.001:aniAxe+40*0.001-0.001,0.5*ones(1,40),'g--')
                aniAxe = aniAxe+40*0.001;
                pause(0.001);
            end
            %aniAxe = aniAxe-tb_ASK(end)-0.001
            if margen == 0
                precont = length(tb_ASK);
                continua = precont;
                margen = 20;
            end
            if get(hObject,'Value') && tb_ASK(end)  <  aniAxe
                set(handles.tog_Animacion,'Value',0);
                set(handles.tog_Animacion,'String','Animacion');
            end
        end
%% PSK
    case 3
        while get(hObject,'Value')
            while get(hObject,'Value') && tb_PSK(precont) > aniAxe
                axes(handles.axes3)
                set(handles.axes3,'XColor',[1 1 1]);
                set(handles.axes3,'YColor',[1 1 1]);
                set(handles.axes3,'Color',[0.6353 0.0784 0.1843]);
                axis([-10+aniAxe 0+aniAxe -Ac*1.25 Ac*1.25]);
                if get(handles.tog_Ruido,'Value')
                    plot(tb_PSK(aniM+1:aniM+40),mod_PSK_e(aniM+1:aniM+40),'b'); hold on;
                else
                    plot(tb_PSK(aniM+1:aniM+40),mod_PSK(aniM+1:aniM+40),'b'); hold on;
                end
                axes(handles.axes5)
                set(handles.axes5,'XColor',[1 1 1]);
                set(handles.axes5,'YColor',[1 1 1]);
                set(handles.axes5,'Color',[0.6353 0.0784 0.1843]);
                axis([-10+aniAxe 0+aniAxe -Ac*1.25 Ac*1.25]);
                plot(tb_PSK(aniM+1:aniM+40),mod_PSK(aniM+1:aniM+40),'b'); hold on;
                
                axes(handles.axes4)
                set(handles.axes4,'XColor',[1 1 1]);
                set(handles.axes4,'YColor',[1 1 1]);
                set(handles.axes4,'Color',[0.6353 0.0784 0.1843]);
                axis([+aniAxeM 10+aniAxeM -2.25*Ac 2.25*Ac]);
                if aniAxe >= 10
                    plot(tb_PSK(aniB+1:aniB+40),demo_PSK(aniB+1:aniB+40),'b'); hold on;
                    if aniB < length(tb_PSK)-40
                        aniB = aniB+40;
                    end
                    if aniAxe >= 11 && aniBit < length(tb_PSK)-40
                        plot(tb_PSK(aniBit+1:aniBit+40)+ts_PSK,demoBits_PSK(aniBit+1:aniBit+40),'g','LineWidth',2); xlabel('segundos'); ylabel('Voltaje'); 
                        axes(handles.axes6)
                        axis([aniAxeM 10+aniAxeM -0.25 Ac+0.25]);
                        plot(tb_PSK(aniBit+1:aniBit+40)+ts_PSK,bit(aniBit+1:aniBit+40),'g','LineWidth',2); hold on;  
                        ylabel('Voltaje'); 
                        set(handles.axes6,'XColor',[1 1 1]);
                        set(handles.axes6,'YColor',[0.6353 0.0784 0.1843]);
                        set(handles.axes6,'Color',[0.6353 0.0784 0.1843]);
                        aniBit = aniBit+40;
                    end
                end
                if aniAxe >= 20
                    aniAxeM = aniAxeM+40*0.001;
                end
                aniM = aniM+40;
                aniAxe = aniAxe+40*0.001;
                pause(0.001);
            end
            while tb_PSK(precont) <= aniAxe && tb_PSK(continua)+margen > aniAxe && get(hObject,'Value')
                axes(handles.axes3)
                set(handles.axes3,'XColor',[1 1 1]);
                set(handles.axes3,'YColor',[1 1 1]);
                set(handles.axes3,'Color',[0.6353 0.0784 0.1843]);
                axis([-10+aniAxe 0+aniAxe -Ac*1.25 Ac*1.25]);
                axes(handles.axes5)
                set(handles.axes5,'XColor',[1 1 1]);
                set(handles.axes5,'YColor',[1 1 1]);
                set(handles.axes5,'Color',[0.6353 0.0784 0.1843]);
                axis([-10+aniAxe 0+aniAxe -Ac*1.25 Ac*1.25]);
                
                axes(handles.axes4)
                set(handles.axes4,'XColor',[1 1 1]);
                set(handles.axes4,'YColor',[1 1 1]);
                set(handles.axes4,'Color',[0.6353 0.0784 0.1843]);
                axis([aniAxeM 10+aniAxeM -2.25*Ac 2.25*Ac]);
                if aniAxe >= 10  
                    plot(tb_PSK(aniB+1:aniB+40),demo_PSK(aniB+1:aniB+40),'b'); hold on;
                    if aniB < length(tb_PSK)-40
                        aniB = aniB+40;
                    end
                    if aniAxe >= 11 && aniBit < length(tb_PSK)-40
                        plot(tb_PSK(aniBit+1:aniBit+40)+ts_PSK,demoBits_PSK(aniBit+1:aniBit+40),'g','LineWidth',2); xlabel('segundos'); ylabel('Voltaje'); 
                        axes(handles.axes6)
                        axis([aniAxeM 10+aniAxeM -0.25 Ac+0.25]);
                        plot(tb_PSK(aniBit+1:aniBit+40)+ts_PSK,bit(aniBit+1:aniBit+40),'g','LineWidth',2); hold on;  
                        ylabel('Voltaje'); 
                        set(handles.axes6,'XColor',[1 1 1]);
                        set(handles.axes6,'YColor',[0.6353 0.0784 0.1843]);
                        set(handles.axes6,'Color',[0.6353 0.0784 0.1843]);
                        aniBit = aniBit+40;                       
                    end
                end
                if aniAxe >= 20
                    aniAxeM = aniAxeM+40*0.001;
                end
                %plot(aniAxe:0.001:aniAxe+40*0.001-0.001,0.5*ones(1,40),'g--')
                aniAxe = aniAxe+40*0.001;
                pause(0.001);
            end
            %aniAxe = aniAxe-tb_ASK(end)-0.001
            if margen == 0
                precont = length(tb_PSK);
                continua = precont;
                margen = 20;
            end
            if get(hObject,'Value') && tb_PSK(end)  <  aniAxe
                set(handles.tog_Animacion,'Value',0);
                set(handles.tog_Animacion,'String','Animacion');
            end
        end
%% FSK
    case 4
        while get(hObject,'Value')
            while get(hObject,'Value') && tb_FSK(precont) > aniAxe
                axes(handles.axes3)
                set(handles.axes3,'XColor',[1 1 1]);
                set(handles.axes3,'YColor',[1 1 1]);
                set(handles.axes3,'Color',[0.6353 0.0784 0.1843]);
                axis([-10+aniAxe 0+aniAxe -Ac*1.25 Ac*1.25]);
                if get(handles.tog_Ruido,'Value')
                    plot(tb_FSK(aniM+1:aniM+40),mod_FSK_e(aniM+1:aniM+40),'b'); hold on;
                else
                    plot(tb_FSK(aniM+1:aniM+40),mod_FSK(aniM+1:aniM+40),'b'); hold on;
                end
                axes(handles.axes5)
                set(handles.axes5,'XColor',[1 1 1]);
                set(handles.axes5,'YColor',[1 1 1]);
                set(handles.axes5,'Color',[0.6353 0.0784 0.1843]);
                axis([-10+aniAxe 0+aniAxe -Ac*1.25 Ac*1.25]);
                plot(tb_FSK(aniM+1:aniM+40),mod_FSK(aniM+1:aniM+40),'b'); hold on;
                axes(handles.axes4)
                set(handles.axes4,'XColor',[1 1 1]);
                set(handles.axes4,'YColor',[1 1 1]);
                set(handles.axes4,'Color',[0.6353 0.0784 0.1843]);
                axis([+aniAxeM 10+aniAxeM -1.25*Ac 1.25*Ac]);
                if aniAxe >= 10
                    plot(tb_FSK(aniB+1:aniB+40),demo_FSK(aniB+1:aniB+40),'b'); hold on;
                    if aniB < length(tb_FSK)-40
                        aniB = aniB+40;
                    end
                    if aniAxe >= 11 && aniBit < length(tb_FSK)-40
                        plot(tb_FSK(aniBit+1:aniBit+40)+ts_FSK,demoBits_FSK(aniBit+1:aniBit+40),'g','LineWidth',2); xlabel('segundos'); ylabel('Voltaje'); 
                        axes(handles.axes6)
                        axis([aniAxeM 10+aniAxeM -0.25 Ac+0.25]);
                        plot(tb_FSK(aniBit+1:aniBit+40)+ts_FSK,bit(aniBit+1:aniBit+40),'g','LineWidth',2); hold on;  
                        ylabel('Voltaje'); 
                        set(handles.axes6,'XColor',[1 1 1]);
                        set(handles.axes6,'YColor',[0.6353 0.0784 0.1843]);
                        set(handles.axes6,'Color',[0.6353 0.0784 0.1843]);
                        aniBit = aniBit+40;
                    end
                end
                if aniAxe >= 20
                    aniAxeM = aniAxeM+40*0.001;
                end
                aniM = aniM+40;
                aniAxe = aniAxe+40*0.001;
                pause(0.001);
            end
            while tb_FSK(precont) <= aniAxe && tb_FSK(continua)+margen > aniAxe && get(hObject,'Value')
                axes(handles.axes3)
                set(handles.axes3,'XColor',[1 1 1]);
                set(handles.axes3,'YColor',[1 1 1]);
                set(handles.axes3,'Color',[0.6353 0.0784 0.1843]);
                axis([-10+aniAxe 0+aniAxe -Ac*1.25 Ac*1.25]);
                axes(handles.axes5)
                set(handles.axes5,'XColor',[1 1 1]);
                set(handles.axes5,'YColor',[1 1 1]);
                set(handles.axes5,'Color',[0.6353 0.0784 0.1843]);
                axis([-10+aniAxe 0+aniAxe -Ac*1.25 Ac*1.25]);
                axes(handles.axes4)
                set(handles.axes4,'XColor',[1 1 1]);
                set(handles.axes4,'YColor',[1 1 1]);
                set(handles.axes4,'Color',[0.6353 0.0784 0.1843]);
                axis([aniAxeM 10+aniAxeM -1.25*Ac 1.25*Ac]);
                if aniAxe >= 10  
                    plot(tb_FSK(aniB+1:aniB+40),demo_FSK(aniB+1:aniB+40),'b'); hold on;
                    if aniB < length(tb_FSK)-40
                        aniB = aniB+40
                    end
                    if aniAxe >= 11 && aniBit < length(tb_FSK)-40
                        plot(tb_FSK(aniBit+1:aniBit+40)+ts_FSK,demoBits_FSK(aniBit+1:aniBit+40),'g','LineWidth',2); xlabel('segundos'); ylabel('Voltaje'); 
                        axes(handles.axes6)
                        axis([aniAxeM 10+aniAxeM -0.25 Ac+0.25]);
                        plot(tb_FSK(aniBit+1:aniBit+40)+ts_FSK,bit(aniBit+1:aniBit+40),'g','LineWidth',2); hold on;  
                        ylabel('Voltaje'); 
                        set(handles.axes6,'XColor',[1 1 1]);
                        set(handles.axes6,'YColor',[0.6353 0.0784 0.1843]);
                        set(handles.axes6,'Color',[0.6353 0.0784 0.1843]);
                        aniBit = aniBit+40;                       
                    end
                end
                if aniAxe >= 20
                    aniAxeM = aniAxeM+40*0.001;
                end
                %plot(aniAxe:0.001:aniAxe+40*0.001-0.001,0.5*ones(1,40),'g--')
                aniAxe = aniAxe+40*0.001;
                pause(0.001);
            end
            %aniAxe = aniAxe-tb_ASK(end)-0.001
            if margen == 0
                precont = length(tb_FSK);
                continua = precont;
                margen = 20;
            end
            if get(hObject,'Value') && tb_FSK(end)  <  aniAxe
                set(handles.tog_Animacion,'Value',0);
                set(handles.tog_Animacion,'String','Animacion');
            end
        end
end


% --- Executes on button press in togglebutton4.
function togglebutton4_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton4


% --- Executes on button press in but_CargarData.
function but_CargarData_Callback(hObject, eventdata, handles)
% hObject    handle to but_CargarData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global M, global Ac, global teta, global fb, global fc, global N; global Opc;
global Datos_estado; global SNR;
Datos_estado = 1;
Opc = get(handles.opciones,'Value');
Ac = str2double(get(handles.Ac,'String'));
teta = str2double(get(handles.teta,'String'))*pi/180;
fb = str2double(get(handles.fb,'String'));
fc = str2double(get(handles.fc,'String'));
N = str2double(get(handles.N,'String'));
M = str2double(get(handles.M,'String'));
SNR = str2double(get(handles.SNR,'String'));
set(handles.tog_Animacion,'Value',0);
set(handles.tog_Animacion,'String','Animacion');
% --- Executes on button press in but_Graficar.

function but_Graficar_Callback(hObject, eventdata, handles)
% hObject    handle to but_Graficar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Opc; global Ac; global Estado_Grafico; global SNR;
global mod_ASK; global ttb_ASK; global DEP_ASK_Onoff; global DEP_ASK_Polar; global f_ASK; global ts_ASK; global B_ASK;
global mod_PSK; global ttb_PSK; global DEP_PSK; global f_PSK; global ts_PSK; global B_PSK;
global mod_FSK; global ttb_FSK; global DEP_FSK; global f_FSK; global ts_FSK; global B_FSK;
%global mod_QAM; global ttb_QAM; global DEP_QAM; global f_QAM; global ts_QAM; global B_QAM;
global demo_ASK; global demo_PSK; global demo_FSK; global bit;
global demoBits_ASK; global demoBits_PSK; global demoBits_FSK;
global mod_ASK_e; global mod_PSK_e; global mod_FSK_e; global mod_QAM_e;
Estado_Grafico = 1;
switch Opc
%% ASK
    case 2
        set(handles.ts,'String',ts_ASK)
        set(handles.fs,'String',1/ts_ASK)
        if get(handles.radbut_Carson,'Value')
            set(handles.AnchodeBanda,'String',B_ASK(1));
            set(handles.B_inf,'String',B_ASK(2));
            set(handles.B_su,'String',B_ASK(3));
        else
            set(handles.AnchodeBanda,'String',B_ASK(4));
            set(handles.B_inf,'String',B_ASK(5));
            set(handles.B_su,'String',B_ASK(6));
        end
        axes(handles.axes3)
        if get(handles.tog_Ruido,'Value')
            plot(ttb_ASK,mod_ASK_e,'b'); axis([0 10 -Ac*1.25 Ac*1.25]); xlabel('segundos'); ylabel('Voltaje')  
        else
            plot(ttb_ASK,mod_ASK,'b'); axis([0 10 -Ac*1.25 Ac*1.25]); xlabel('segundos'); ylabel('Voltaje')  
        end
        set(handles.axes3,'Color',[0.6353 0.0784 0.1843]);
        set(handles.axes3,'XColor',[1 1 1]);
        set(handles.axes3,'YColor',[1 1 1]);
        axes(handles.axes4)
        plot(ttb_ASK+0.001,demo_ASK,'b'); hold on;
        plot(ttb_ASK+ts_ASK,demoBits_ASK,'g','LineWidth',2); axis([0 10 -2.25*Ac 2.25*Ac]); xlabel('segundos'); ylabel('Voltaje')
        set(handles.axes4,'Color',[0.6353 0.0784 0.1843]);
        set(handles.axes4,'XColor',[1 1 1]);
        set(handles.axes4,'YColor',[1 1 1]);
        axes(handles.axes5)
        plot(ttb_ASK,mod_ASK,'b'); axis([0 10 -Ac*1.25 Ac*1.25]); ylabel('Voltaje')
        set(handles.axes5,'Color',[0.6353 0.0784 0.1843]);
        set(handles.axes5,'XColor',[1 1 1]);
        set(handles.axes5,'YColor',[1 1 1]);
        axes(handles.axes6)
        plot(ttb_ASK+ts_ASK,bit,'g','LineWidth',2); axis([0 10 -0.25 1.25]); ylabel('Voltaje')
        set(handles.axes6,'Color',[0.6353 0.0784 0.1843]);
        set(handles.axes6,'XColor',[1 1 1]);
        set(handles.axes6,'YColor',[1 1 1]);
        if str2double(get(handles.N,'String')) == 0
            axes(handles.axes2)
            plot(f_ASK,DEP_ASK_Onoff,'c','LineWidth',2); axis tight; xlabel('Hz'); ylabel('|H(f)|')
            set(handles.Amplitud,'String',B_ASK(7));
        else
            axes(handles.axes2)
            plot(f_ASK,DEP_ASK_Polar,'c','LineWidth',2); axis tight; xlabel('Hz'); ylabel('|H(f)|')
            set(handles.Amplitud,'String',B_ASK(8));
        end
        set(handles.axes2,'Color',[0.6353 0.0784 0.1843]);
        set(handles.axes2,'XColor',[1 1 1]);
        set(handles.axes2,'YColor',[1 1 1]);
        axes(handles.axes8)
        if get(handles.tog_Ruido,'Value')
            plot(ttb_ASK,awgn(ones(1,length(ttb_ASK)),SNR));
        else
           plot(ttb_ASK,zeros(1,length(ttb_ASK))); 
        end
        set(handles.axes8,'Color',[0.6353 0.0784 0.1843]);
        set(handles.axes8,'XColor',[1 1 1]);
        set(handles.axes8,'YColor',[1 1 1]);
        
%% PSK
    case 3
        set(handles.ts,'String',ts_PSK)
        set(handles.fs,'String',1/ts_PSK)
        if get(handles.radbut_Carson,'Value')
            set(handles.AnchodeBanda,'String',B_PSK(1));
            set(handles.B_inf,'String',B_PSK(2));
            set(handles.B_su,'String',B_PSK(3));
        else
            set(handles.AnchodeBanda,'String',B_PSK(4));
            set(handles.B_inf,'String',B_PSK(5));
            set(handles.B_su,'String',B_PSK(6));
        end
        set(handles.Amplitud,'String',B_PSK(7));
        axes(handles.axes3)
        if get(handles.tog_Ruido,'Value')
            plot(ttb_PSK,mod_PSK_e,'b'); axis([0 10 -Ac*1.25 Ac*1.25]); xlabel('segundos'); ylabel('Voltaje')
        else
            plot(ttb_PSK,mod_PSK,'b'); axis([0 10 -Ac*1.25 Ac*1.25]); xlabel('segundos'); ylabel('Voltaje')
        end
        set(handles.axes3,'Color',[0.6353 0.0784 0.1843]);
        set(handles.axes3,'XColor',[1 1 1]);
        set(handles.axes3,'YColor',[1 1 1]);
        axes(handles.axes4)
        plot(ttb_PSK+0.001,demo_PSK,'b'); hold on;
        plot(ttb_PSK+ts_PSK,demoBits_PSK,'g','LineWidth',2); axis([0 10 -2.25*Ac 2.25*Ac]); xlabel('segundos'); ylabel('Voltaje')
        set(handles.axes4,'Color',[0.6353 0.0784 0.1843]);
        set(handles.axes4,'XColor',[1 1 1]);
        set(handles.axes4,'YColor',[1 1 1]);
        axes(handles.axes5)
        plot(ttb_PSK,mod_PSK,'b'); axis([0 10 -Ac*1.25 Ac*1.25]); ylabel('Voltaje')
        set(handles.axes5,'Color',[0.6353 0.0784 0.1843]);
        set(handles.axes5,'XColor',[1 1 1]);
        set(handles.axes5,'YColor',[1 1 1]);
        axes(handles.axes6)
        plot(ttb_PSK+ts_PSK,bit,'g','LineWidth',2); axis([0 10 -0.25 1.25]); ylabel('Voltaje')
        set(handles.axes6,'Color',[0.6353 0.0784 0.1843]);
        set(handles.axes6,'XColor',[1 1 1]);
        set(handles.axes6,'YColor',[1 1 1]);
        axes(handles.axes2)
        plot(f_PSK,DEP_PSK,'c','LineWidth',2); axis tight; xlabel('Hz'); ylabel('|H(f)|')
        set(handles.axes2,'Color',[0.6353 0.0784 0.1843]);
        set(handles.axes2,'XColor',[1 1 1]);
        set(handles.axes2,'YColor',[1 1 1]);
        axes(handles.axes8)
        if get(handles.tog_Ruido,'Value')
            plot(ttb_PSK,awgn(ones(1,length(ttb_PSK)),SNR));
        else
           plot(ttb_PSK,zeros(1,length(ttb_PSK))); 
        end
        set(handles.axes8,'Color',[0.6353 0.0784 0.1843]);
        set(handles.axes8,'XColor',[1 1 1]);
        set(handles.axes8,'YColor',[1 1 1]);
%% FSK
    case 4
        set(handles.ts,'String',ts_FSK)
        set(handles.fs,'String',1/ts_FSK)
        if get(handles.radbut_Carson,'Value')
            set(handles.AnchodeBanda,'String',B_FSK(1));
            set(handles.B_inf,'String',B_FSK(2));
            set(handles.B_su,'String',B_FSK(3));
        else
            set(handles.AnchodeBanda,'String',B_FSK(4));
            set(handles.B_inf,'String',B_FSK(5));
            set(handles.B_su,'String',B_FSK(6));
        end
        set(handles.Amplitud,'String',B_FSK(7));
        axes(handles.axes3)
        if get(handles.tog_Ruido,'Value')
            plot(ttb_FSK,mod_FSK_e,'b'); axis([0 10 -Ac*1.25 Ac*1.25]); xlabel('segundos'); ylabel('Voltaje')
        else
            plot(ttb_FSK,mod_FSK,'b'); axis([0 10 -Ac*1.25 Ac*1.25]); xlabel('segundos'); ylabel('Voltaje')
        end
        set(handles.axes3,'Color',[0.6353 0.0784 0.1843]);
        set(handles.axes3,'XColor',[1 1 1]);
        set(handles.axes3,'YColor',[1 1 1]);
        axes(handles.axes4)
        plot(ttb_FSK+0.001,demo_FSK,'b'); hold on;
        plot(ttb_FSK+ts_FSK,demoBits_FSK,'g','LineWidth',2); axis([0 10 -1.25*Ac 1.25*Ac]); xlabel('segundos'); ylabel('Voltaje')
        set(handles.axes4,'Color',[0.6353 0.0784 0.1843]);
        set(handles.axes4,'XColor',[1 1 1]);
        set(handles.axes4,'YColor',[1 1 1]);
        axes(handles.axes5)
        plot(ttb_FSK,mod_FSK,'b'); axis([0 10 -Ac*1.25 Ac*1.25]); ylabel('Voltaje')
        set(handles.axes5,'Color',[0.6353 0.0784 0.1843]);
        set(handles.axes5,'XColor',[1 1 1]);
        set(handles.axes5,'YColor',[1 1 1]);
        axes(handles.axes6)
        plot(ttb_FSK+ts_FSK,bit,'g','LineWidth',2); axis([0 10 -0.25 1.25]); ylabel('Voltaje')
        set(handles.axes6,'Color',[0.6353 0.0784 0.1843]);
        set(handles.axes6,'XColor',[1 1 1]);
        set(handles.axes6,'YColor',[1 1 1]);
        axes(handles.axes2)
        plot(f_FSK,DEP_FSK,'c','LineWidth',2); axis tight; xlabel('Hz'); ylabel('|H(f)|')
        set(handles.axes2,'Color',[0.6353 0.0784 0.1843]);
        set(handles.axes2,'XColor',[1 1 1]);
        set(handles.axes2,'YColor',[1 1 1]);
        axes(handles.axes8)
        if get(handles.tog_Ruido,'Value')
            plot(ttb_FSK,awgn(ones(1,length(ttb_FSK)),SNR));
        else
           plot(ttb_FSK,zeros(1,length(ttb_FSK))); 
        end
        set(handles.axes8,'Color',[0.6353 0.0784 0.1843]);
        set(handles.axes8,'XColor',[1 1 1]);
        set(handles.axes8,'YColor',[1 1 1]);
    case 5
        set(handles.ts,'String',ts_QAM)
        set(handles.fs,'String',1/ts_QAM)
        if get(handles.radbut_Carson,'Value')
            set(handles.AnchodeBanda,'String',B_QAM(1));
            set(handles.B_inf,'String',B_QAM(2));
            set(handles.B_su,'String',B_QAM(3));
        else
            set(handles.AnchodeBanda,'String',B_QAM(4));
            set(handles.B_inf,'String',B_QAM(5));
            set(handles.B_su,'String',B_QAM(6));
        end
        axes(handles.axes3)
        plot(ttb_QAM,mod_QAM); axis tight; xlabel('segundos'); ylabel('Voltaje')
        axes(handles.axes2)
        plot(f_QAM,DEP_QAM); axis tight; xlabel('Hz'); ylabel('|H(f)|')
      
end
% --- Executes on button press in but_Limpiar.
function but_Limpiar_Callback(hObject, eventdata, handles)
% hObject    handle to but_Limpiar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global aniM; global aniAxe; global bitsM; global bits; global t; 
global div; global ax_bits; global Datos_estado; global continua;
global tb_ASK; global tb_PSK; global tb_FSK; global tb_QAM;
global aniAxeM; global aniB; global aniBit; global Estado_Grafico;
if ~get(hObject,'Value')
    set(hObject,'String','Animacion')
end
tb_ASK = []; tb_PSK = []; tb_FSK = []; tb_QAM = [];
continua = 0;
Datos_estado = 0; Estado_Grafico = 0;
ax_bits = 0;
aniAxe = 0; aniB = 0; aniBit = 0;
aniAxeM = 0;
t = 0;
aniM = 0;
bitsM = '';
bits = [];
div = [0 1];
%get(handles.axes_bits);
axes(handles.axes_bits); cla;
axes(handles.axes2); cla;
axes(handles.axes3); cla;
axes(handles.axes4); cla;
axes(handles.axes5); cla;
axes(handles.axes6); cla;
axes(handles.axes8); cla;
axes(handles.axes_ondas); cla;
set(handles.text_mosbits,'String','')
set(handles.text_numbits,'String','')
set(handles.ts,'String','')
set(handles.fs,'String','')
set(handles.AnchodeBanda,'String','')
set(handles.B_inf,'String','')
set(handles.B_su,'String','')
set(handles.Amplitud,'String','')
set(handles.SNR,'String',5)
set(handles.axes_bits,'XColor',[1 1 1]);
set(handles.axes_bits,'YColor',[0.6353 0.0784 0.1843]);
set(handles.axes_bits,'Color',[0.6353 0.0784 0.1843]);
set(handles.axes6,'Color',[0.6353 0.0784 0.1843]);
set(handles.radbut_Carson,'Value',1);
set(handles.radbut_PrLobulo,'Value',0);
set(handles.tog_Ruido,'Value',0);
set(handles.tog_Ruido,'String','ConRuido');

% --- Executes on button press in but_GenerarData.
function but_GenerarData_Callback(hObject, eventdata, handles)
% hObject    handle to but_GenerarData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global M,global Ac, global teta, global fb, global fc, global bits; global margen;
global Opc; global ttb_ASK; global ttb_PSK; global ttb_FSK; global ttb_QAM; 
global N; global Datos_estado; global aniAxe; global continua; global precont;
global mod_ASK; global tb_ASK; global DEP_ASK_Onoff; global DEP_ASK_Polar; global f_ASK; global ts_ASK; global B_ASK;
global mod_PSK; global tb_PSK; global DEP_PSK; global f_PSK; global ts_PSK; global B_PSK;
global mod_FSK; global tb_FSK; global DEP_FSK; global f_FSK; global ts_FSK; global B_FSK;
global mod_QAM; global tb_QAM; global DEP_QAM; global f_QAM; global ts_QAM; global B_QAM;
global demo_ASK; global demo_PSK; global demo_FSK; global bit;
global demoBits_ASK; global demoBits_PSK; global demoBits_FSK; global SNR;
global mod_ASK_e; global mod_PSK_e; global mod_FSK_e; global mod_QAM_e;
Datos_estado = 1;
margen = 0;
switch Opc 
    case 2
        precont = length(tb_ASK);
        [mod_ASK,tb_ASK, DEP_ASK_Onoff, DEP_ASK_Polar, f_ASK, ts_ASK, B_ASK] = ASK(M,bits,Ac,fb,fc,teta,N,0.001);
        ttb_ASK = tb_ASK;
        tb_ASK(continua+1:end) = tb_ASK(continua+1:end)+ceil(aniAxe-tb_ASK(precont+1));
        if get(handles.tog_Ruido,'Value')
            mod_ASK_e = awgn(mod_ASK, SNR)
        else
            mod_ASK_e = mod_ASK;
            SNR = 100;
        end
        if get(handles.RadButFilAdap,'Value')
            [demoBits_ASK, demo_ASK, bit] = Demodulacion(mod_ASK_e,tb_ASK,M,Ac,fc,fb,teta,0.001,Opc,N,SNR);
        else
            [demoBits_ASK, demo_ASK, bit] = Correlador(mod_ASK_e,tb_ASK,M,Ac,fc,fb,teta,0.001,Opc,N,SNR);
        end
        continua = length(tb_ASK);
    case 3
        precont = length(tb_PSK);
        [mod_PSK, tb_PSK, DEP_PSK, f_PSK, ts_PSK, B_PSK] = PSK(M,bits,Ac,fb,fc,teta,N,0.001);
        ttb_PSK = tb_PSK;
        tb_PSK(continua+1:end) = tb_PSK(continua+1:end)+ceil(aniAxe-tb_PSK(precont+1));
        if get(handles.tog_Ruido,'Value')
            mod_PSK_e = awgn(mod_PSK, SNR)
        else
            mod_PSK_e = mod_PSK;
            SNR = 100;
        end
        if get(handles.RadButFilAdap,'Value')
            [demoBits_PSK, demo_PSK, bit] = Demodulacion(mod_PSK,tb_PSK,M,Ac,fc,fb,teta,0.001,Opc,N,SNR);
        else
            [demoBits_PSK, demo_PSK, bit] = Correlador(mod_PSK,tb_PSK,M,Ac,fc,fb,teta,0.001,Opc,N,SNR);
        end
        continua = length(tb_PSK);
    case 4
        precont = length(tb_FSK);
        [mod_FSK, tb_FSK, DEP_FSK, f_FSK, ts_FSK, B_FSK] = FSK(M,bits,Ac,fb,fc,teta,N,0.001);
        ttb_FSK = tb_FSK;
        tb_FSK(continua+1:end) = tb_FSK(continua+1:end)+ceil(aniAxe-tb_FSK(precont+1));
        if get(handles.tog_Ruido,'Value')
            mod_FSK_e = awgn(mod_FSK, SNR)
        else
            mod_FSK_e = mod_FSK;
            SNR = 100;
        end
        if get(handles.RadButFilAdap,'Value')
            [demoBits_FSK, demo_FSK, bit] = Demodulacion(mod_FSK,tb_FSK,M,Ac,fc,fb,teta,0.001,Opc,N,SNR);
        else
            [demoBits_FSK, demo_FSK, bit] = Correlador(mod_FSK,tb_FSK,M,Ac,fc,fb,teta,0.001,Opc,N,SNR);
        end
        continua = length(tb_FSK);
    case 5
        precont = length(tb_QAM);
        [mod_QAM, tb_QAM, DEP_QAM, f_QAM, ts_QAM, B_QAM] = QAM(M,bits,Ac,fb,fc,teta,N,0.001);
        ttb_QAM = tb_QAM;
        tb_QAM(continua+1:end) = tb_QAM(continua+1:end)+ceil(aniAxe-tb_QAM(precont+1));
        if get(handles.tog_Ruido,'Value')
            mod_QAM_e = awgn(mod_QAM, SNR)
        else
            mod_QAM_e = mod_QAM;
        end
        continua = length(tb_QAM);
end

if precont == 0
    precont = continua;
    margen = 20;
else
    continua = precont+1;
end    
    
function ts_Callback(hObject, eventdata, handles)
% hObject    handle to ts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ts as text
%        str2double(get(hObject,'String')) returns contents of ts as a double


% --- Executes during object creation, after setting all properties.
function ts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AnchodeBanda_Callback(hObject, eventdata, handles)
% hObject    handle to AnchodeBanda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AnchodeBanda as text
%        str2double(get(hObject,'String')) returns contents of AnchodeBanda as a double


% --- Executes during object creation, after setting all properties.
function AnchodeBanda_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AnchodeBanda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fs_Callback(hObject, eventdata, handles)
% hObject    handle to fs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fs as text
%        str2double(get(hObject,'String')) returns contents of fs as a double


% --- Executes during object creation, after setting all properties.
function fs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radbut_Carson.
function radbut_Carson_Callback(hObject, eventdata, handles)
% hObject    handle to radbut_Carson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Opc; global Datos_estado; global B_PSK; global B_FSK; global B_ASK; global B_QAM;
switch Opc
    case 2
        if Datos_estado == 1 && get(handles.radbut_Carson,'Value')
            set(handles.AnchodeBanda,'String',B_ASK(1));
            set(handles.B_inf,'String',B_ASK(2));
            set(handles.B_su,'String',B_ASK(3));
        end
    case 3
        if Datos_estado == 1 && get(handles.radbut_Carson,'Value')
            set(handles.AnchodeBanda,'String',B_PSK(1));
            set(handles.B_inf,'String',B_PSK(2));
            set(handles.B_su,'String',B_PSK(3));
        end
    case 4
        if Datos_estado == 1 && get(handles.radbut_Carson,'Value')
            set(handles.AnchodeBanda,'String',B_FSK(1));
            set(handles.B_inf,'String',B_FSK(2));
            set(handles.B_su,'String',B_FSK(3));
        end
    case 5
        if Datos_estado == 1 && get(handles.radbut_Carson,'Value')
            set(handles.AnchodeBanda,'String',B_QAM(1));
            set(handles.B_inf,'String',B_QAM(2));
            set(handles.B_su,'String',B_QAM(3));
        end
end
if get(handles.radbut_Carson,'Value')
    set(handles.radbut_PrLobulo,'Value',0)
end
% Hint: get(hObject,'Value') returns toggle state of radbut_Carson


% --- Executes on button press in radbut_PrLobulo.
function radbut_PrLobulo_Callback(hObject, eventdata, handles)
% hObject    handle to radbut_PrLobulo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Opc; global Datos_estado; global B_ASK; global B_PSK; global B_FSK; global B_QAM;
switch Opc
    case 2
        if Datos_estado == 1 && get(handles.radbut_PrLobulo,'Value')
            set(handles.AnchodeBanda,'String',B_ASK(4));
            set(handles.B_inf,'String',B_ASK(5));
            set(handles.B_su,'String',B_ASK(6));
        end
    case 3
        if Datos_estado == 1 && get(handles.radbut_Carson,'Value')
            set(handles.AnchodeBanda,'String',B_PSK(4));
            set(handles.B_inf,'String',B_PSK(5));
            set(handles.B_su,'String',B_PSK(6));
        end
    case 4
        if Datos_estado == 1 && get(handles.radbut_Carson,'Value')
            set(handles.AnchodeBanda,'String',B_FSK(4));
            set(handles.B_inf,'String',B_FSK(5));
            set(handles.B_su,'String',B_FSK(6));
        end
    case 5
        if Datos_estado == 1 && get(handles.radbut_Carson,'Value')
            set(handles.AnchodeBanda,'String',B_QAM(4));
            set(handles.B_inf,'String',B_QAM(5));
            set(handles.B_su,'String',B_QAM(6));
        end
end
if get(handles.radbut_PrLobulo,'Value')
    set(handles.radbut_Carson,'Value',0)
end
% Hint: get(hObject,'Value') returns toggle state of radbut_PrLobulo



function B_su_Callback(hObject, eventdata, handles)
% hObject    handle to B_su (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of B_su as text
%        str2double(get(hObject,'String')) returns contents of B_su as a double


% --- Executes during object creation, after setting all properties.
function B_su_CreateFcn(hObject, eventdata, handles)
% hObject    handle to B_su (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function B_inf_Callback(hObject, eventdata, handles)
% hObject    handle to B_inf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of B_inf as text
%        str2double(get(hObject,'String')) returns contents of B_inf as a double


% --- Executes during object creation, after setting all properties.
function B_inf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to B_inf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Amplitud_Callback(hObject, eventdata, handles)
% hObject    handle to Amplitud (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Amplitud as text
%        str2double(get(hObject,'String')) returns contents of Amplitud as a double


% --- Executes during object creation, after setting all properties.
function Amplitud_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Amplitud (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SNR_Callback(hObject, eventdata, handles)
% hObject    handle to SNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SNR as text
%        str2double(get(hObject,'String')) returns contents of SNR as a double


% --- Executes during object creation, after setting all properties.
function SNR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in tog_Ruido.
function tog_Ruido_Callback(hObject, eventdata, handles)
% hObject    handle to tog_Ruido (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    set(hObject,'String','SinRuido');
else
    set(hObject,'String','ConRuido');
end
% Hint: get(hObject,'Value') returns toggle state of tog_Ruido


% --- Executes on button press in RadButFilAdap.
function RadButFilAdap_Callback(hObject, eventdata, handles)
% hObject    handle to RadButFilAdap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')
    set(handles.RadButFilCorr,'Value',0)
end
% Hint: get(hObject,'Value') returns toggle state of RadButFilAdap


% --- Executes on button press in RadButFilCorr.
function RadButFilCorr_Callback(hObject, eventdata, handles)
% hObject    handle to RadButFilCorr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')
    set(handles.RadButFilAdap,'Value',0)
end
% Hint: get(hObject,'Value') returns toggle state of RadButFilCorr

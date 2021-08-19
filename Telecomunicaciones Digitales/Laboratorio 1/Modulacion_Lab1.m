function varargout = Modulacion_Lab1(varargin)
% MODULACION_LAB1 MATLAB code for Modulacion_Lab1.fig
%      MODULACION_LAB1, by itself, creates a new MODULACION_LAB1 or raises the existing
%      singleton*.
%
%      H = MODULACION_LAB1 returns the handle to a new MODULACION_LAB1 or the handle to
%      the existing singleton*.
%
%      MODULACION_LAB1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODULACION_LAB1.M with the given input arguments.
%
%      MODULACION_LAB1('Property','Value',...) creates a new MODULACION_LAB1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Modulacion_Lab1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Modulacion_Lab1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Modulacion_Lab1

% Last Modified by GUIDE v2.5 10-Apr-2019 10:11:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Modulacion_Lab1_OpeningFcn, ...
                   'gui_OutputFcn',  @Modulacion_Lab1_OutputFcn, ...
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


% --- Executes just before Modulacion_Lab1 is made visible.
function Modulacion_Lab1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Modulacion_Lab1 (see VARARGIN)

% Choose default command line output for Modulacion_Lab1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Modulacion_Lab1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global fc; fc = 0;
global fb; fb = 0;
global ts; ts = 0;
global fs; fs = 0;
global tb; tb = 0;
global n; n = 0;
global M; M = 0;
global Ac; Ac = 0;
global teta; teta = 0;
global Opc; Opc = 0;
global bitsG; bitsG = [];
global bitsM; bitsM = '';
global pres; pres = 0.001;
set(handles.checkbox2,'Value',1);
% --- Outputs from this function are returned to the command line.
function varargout = Modulacion_Lab1_OutputFcn(hObject, eventdata, handles) 
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
global Adep;
global B;
global Binf;
global Bsup;
global fc;
global fb;
global ts;
global fs;
global tb;
global n;
global M;
global N;
global Ac;
global teta;
global Opc;
global bits;
global pres;
global bitsG; 
teta = teta*pi/180;
lfc = fc;
presCon = 0;
while lfc > 1
    lfc = lfc/10;
    presCon = presCon+1;
end
pres = 1/(10^(presCon+2));
set(handles.text21,'String',num2str(pres));

if (get(handles.checkbox2,'Value') && Opc ~= 4)
    p=0;
    n = log2(M);
    disp('condicional')
    for i = 1:n:length(bitsG)
        num = [bitsG((1+n*p):1:(n+n*p))];
        p = p+1;
        dec = [num(1)];
        for j=1:1:n-1
            if num(j+1) + dec(j) > 1
                dec = [dec 0];
            else
                if num(j+1) == 0 && 0 == dec(j)
                    dec = [dec 0];
                else
                    dec = [dec 1];
                end
            end
        end
        bits = [bits dec];
    end
else
    bits = bitsG;
    n = 0;
end
bits
dec = [];
switch Opc
%% M - ASK    
    case 2
        tb = 1/fb;
        ak = 0:1:M-1;
        n = log2(M);
        ts = n*tb;
        niveles = [];
        p=0;
        for i = 1:n:length(bits)
            dec = [bits((1+n*p):1:(n+n*p))];
            h = 1;
            nivel = 0;
            for ind = n-1:-1:0
                nivel = nivel + dec(h)*(2^ind);
                h = h+1;
            end
            niveles = [niveles nivel];
            p = p+1;
        end
        Nb = length(bits); 
        t = 0:pres:tb-pres;
        tt = 0:pres:tb*(Nb/n)-pres;
        senal=Ac*cos(2*pi*fc.*t+teta);
        xc=[];
        for i=1:length(niveles)
            xc=[xc niveles(i)*senal];
        end
        xc
        axes(handles.axes2)
        grid minor; xlabel('segundos'); ylabel('Amplitud'); %axis tight;
        plot(tt, Ac*cos(2*pi*fc.*tt+teta),'r' ) 
        grid minor; xlabel('segundos'); ylabel('Amplitud'); %axis tight;
        axes(handles.axes4)
        plot(tt,xc); grid minor; xlabel('Segundos'); ylabel('Amplitud'); %axis tight;
        f = -2*fc:pres:2*fc;
        fs = 1/ts;
        DEP_ASK = ((Ac^2)/4)*((M^2-1)./(12.*fs).*(sinc((f+fc)./fs)).^2 + (M^2-1)./(12.*fs).*(sinc((f-fc)./fs)).^2);
        axes(handles.axes5)
        plot(f,DEP_ASK); hold on;
        xlabel('Hz'); ylabel('DEP')
        stem([-fc fc],[Ac^2*(M-1)^2/16 Ac^2*(M-1)^2/16]); hold on;
        grid minor, axis tight
        
        B = 2*fs;
        Binf = fc-fs/2;
        Bsup = fc+fs/2;
        Adep = max(xc);
%% M - PSK
    case 3
        n = log2(M);
        p=0;
        c = [];
        niveles = [];
        for i = 1:n:length(bits)
            dec = [bits((1+n*p):1:(n+n*p))];
            p = p+1;
            h = 1;
            nivel = 0;
            for ind = n-1:-1:0
                nivel = nivel + dec(h)*(2^ind);
                h = h+1;
            end
            niveles = [niveles nivel];
        end
        fik=[]; ik=[]; qk=[];
        switch N
            case 0
                for i=1:length(niveles)
                    fik=[fik pi*niveles(i)/2];
                    ik=[ik cos(fik(i))];
                    qk=[qk sin(fik(i))];
                end
            case 1
                for i=1:length(niveles)
                    fik=[fik pi*(2*niveles(i)+1)/4];
                    ik=[ik cos(fik(i))];
                    qk=[qk sin(fik(i))];
                end
        end
        tb = 1/fb;
        ts = n*tb
        Nb = length(bits); 
        t = 0:pres:tb-pres;
        tt = 0:pres:tb*(Nb/n)-pres;
        senalc=Ac*cos(2*pi*fc.*t+teta);
        senals=-Ac*sin(2*pi*fc.*t+teta);
        % Señal
        xi=[];
        for i=1:length(niveles)
            xi=[xi ik(i)*senalc];
        end
        axes(handles.axes2)
        plot(tt,xi); grid minor
        xq=[];
        for i=1:length(niveles)
            xq=[xq qk(i)*senals];
        end
        axes(handles.axes3)
        plot(tt,xq); grid minor
        xt=xi+xq; 
        axes(handles.axes4)
        plot(tt,xt); grid minor
        f = -2*fc:pres:2*fc;
        fs=fb/n;
        DEP_PSK = (Ac^2./4)*( (1/fs)*(sinc((f+fc)./fs)).^2 + (1/fs)*(sinc((f-fc)./fs)).^2 );
        axes(handles.axes5)
        plot(f,DEP_PSK); xlabel('Hz'); ylabel('DEP'); grid minor; axis tight
        B = 2*fs;
        Binf = fc-fs/2;
        Bsup = fc+fs/2;
        Adep = max(xt);
%% M - QAM      
    case 4
        tb = 1/fb;
        u = sqrt(M);
        n = log2(u);
        ts = n*tb*2;
        Ik = [(-u+1):2:-1 1:2:(u-1)];
        Qk = [(-u+1):2:-1 1:2:(u-1)];
        Nb = length(bits);
        t = 0:pres:2*n*tb-pres;
        tt = 0:pres:2*n*tb*(Nb/(n*2))-pres;
        Limk = length(bits)/(n*2);
        VH = [bits(1:2:end)];
        VL = [bits(2:2:end)];
        Xi = [];
        Xq = [];
        p = 0;
        for k = 1:1:Limk
            ParBits = [VH((1+n*p):1:(n+n*p))];
            if get(handles.checkbox2,'Value')
                dec = [ParBits(1)];
                for j=1:1:n-1
                    if ParBits(j+1) + dec(j) > 1
                        dec = [dec 0];
                    else
                        if ParBits(j+1) == 0 && 0 == dec(j)
                            dec = [dec 0];
                        else
                            dec = [dec 1];
                        end
                    end
                end
                ParBits = dec;
            end
            nivel = 0; h = 1;
            for ind = n-1:-1:0
                nivel = nivel + ParBits(h)*(2^ind);
                h = h+1;
            end
            Xi = [Xi Ik(nivel+1).*ones(1,2*n*tb/pres)];
          
            ParBits = [VL((1+n*p):1:(n+n*p))];
            if get(handles.checkbox2,'Value')
                dec = [ParBits(1)];
                for j=1:1:n-1
                    if ParBits(j+1) + dec(j) > 1
                        dec = [dec 0];
                    else
                        if ParBits(j+1) == 0 && 0 == dec(j)
                            dec = [dec 0];
                        else
                            dec = [dec 1];
                        end
                    end
                end
                ParBits = dec;
            end
            nivel = 0; h = 1;
            for ind = n-1:-1:0
                nivel = nivel + ParBits(h)*(2^ind);
                h = h+1;
            end
            Xq = [Xq Qk(nivel+1).*ones(1,2*n*tb/pres)];
            p = p+1;
        end
        portadoraCos = cos(2*pi*fc*tt+teta)*Ac;
        portadoraSen = -sin(2*pi*fc*tt+teta)*Ac;
        XiCos = Xi.*portadoraCos;
        XqSen = Xq.*portadoraSen;
        Xc = XiCos + XqSen;
        axes(handles.axes2)
        plot(tt,XiCos); grid minor; xlabel('segundos'); ylabel('Amplitud'); axis tight  
        axes(handles.axes3)
        plot(tt,XqSen); grid minor; xlabel('segundos'); ylabel('Amplitud'); axis tight
        axes(handles.axes4)
        plot(tt,Xc); grid minor; xlabel('segundos'); ylabel('Amplitud'); axis tight
        f = -2*fc:pres:2*fc;
        fs=fb/n;
        DEP_PSK = ( ( (Ac^2)*2*(u^2-1) )/(12*fs))*( sinc((f+fc)./fs).^2 + sinc((f-fc)./fs).^2 );
        axes(handles.axes5)
        plot(f,DEP_PSK); xlabel('Hz'); ylabel('DEP'); grid minor; axis tight
        B = 2*fs;
        Binf = fc-fs/2;
        Bsup = fc+fs/2;
        Adep = max(Xc);
 %% M - FSK
    case 5
        tb = 1/fb;
        n = log2(M);
        ts = n*tb;
        Nb = length(bits); 
        t = 0:pres:tb-pres;
        tt = 0:pres:tb*(Nb/n)-pres;
        b = [(-M+1):2:-1 1:2:(M-1)];
        p = 0;
        %teta = 0;
        AngRot = 0;
        SumCos = [];
        SumSen = [];
        for k = 0:1:Nb/n-1
            num = bits((1+n*p):1:(n+n*p));
            h = 1;
            nivel = 0;
            for ind = n-1:-1:0
                nivel = nivel + num(h)*(2^ind);
                h = h+1;
            end
            SumCos = [SumCos cos(pi*fb*b(nivel+1).*t+AngRot)];
            SumSen = [SumSen ((-1)^k).*sin(pi*fb*b(nivel+1).*t)];
            AngRot = AngRot + pi;
            p = p+1;
        end
        portadoraCos = cos(2*pi*fc*tt+teta)*Ac;
        portadoraSen = -sin(2*pi*fc*tt+teta)*Ac;
        
        SumCosGr = SumCos.*portadoraCos;
        SumSenGr = SumSen.*portadoraSen;
        Xc = SumCosGr + SumSenGr;
        axes(handles.axes2)
        plot(tt,SumCosGr); xlabel('Segundos'); ylabel('Amplitud'); grid minor; axis tight
        axes(handles.axes3)
        plot(tt,SumSenGr); xlabel('Segundos'); ylabel('Amplitud'); grid minor; axis tight
        axes(handles.axes4)
        plot(tt,Xc); xlabel('Segundos'); ylabel('Amplitud'); grid minor; axis tight
        f = -2*fc:pres:2*fc;
        DEP_FSK = [((Ac^2)./4).* ( (4./(pi*pi*fb)).*((cos(pi*(f+fc)./fb)./(((2*(f+fc)./fb).^2)-1)).^2) + (4./(pi*pi*fb)).*((cos(pi*(f-fc)./fb)./(((2*(f-fc)./fb).^2)-1)).^2) )]; 
        f_con = [-fc-fb/2 -fc+fb/2 fc-fb/2 fc+fb/2];
        DEP_CON = (Ac^2/16).*[1 1 1 1];
        axes(handles.axes5)
        plot(f,DEP_FSK); xlabel('Hz'); ylabel('DEP'); grid on; hold on
        stem(f_con,DEP_CON); grid minor; axis tight
        B = 3*fb;
        Binf = fc-3*fb/2;
        Bsup = fc+3*fb/2;
        Adep = max(Xc);
    otherwise
        disp('Opcion invalida')
end
fs = 1/ts;
set(handles.edit10,'String',num2str(ts));
set(handles.edit12,'String',num2str(fs));
set(handles.edit13,'String',num2str(B));
set(handles.edit14,'String',num2str(Binf));
set(handles.edit15,'String',num2str(Bsup));
set(handles.edit16,'String',num2str(Adep));
set(handles.pushbutton1,'Enable','off');
clear all;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fc;
global fb;
global Ac;
global M;
global teta;
global Opc;
global N;
global bitsG; 
fc = str2double(get(handles.edit9,'String'));
fb = str2double(get(handles.edit8,'String'));
Ac = str2double(get(handles.edit6,'String'));
teta = str2double(get(handles.edit7,'String'));
M = str2double(get(handles.edit2,'String'));
Opc = get(handles.popupmenu1,'Value')
N = str2double(get(handles.edit11,'String'));
tb = 1/fb;
Nb = length(bitsG);

t = 0:0.001:1-0.001;
tt = 0:0.001:Nb-0.001;
Puls = ones(1,Nb)*0.75;
Puls(2:2:end) = 0.25;
GrPuls = [];
GrBits = [];
for i = 1:1:Nb
    GrBits = [GrBits bitsG(i)*ones(1,length(t))];
    GrPuls = [GrPuls Puls(i)*ones(1,length(t))];
end
axes(handles.axes1)
plot(tt,GrBits,'LineWidth',2); xlabel('Segundos'); ylabel('Amplitud'); grid on; hold on
plot(tt,GrPuls); axis([-0.005 tt(end)+0.005 -0.5 1.5]);

function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

if get(hObject,'Value') ~= 3
    set(handles.edit11,'Enable','off');
else
    set(handles.edit11,'Enable','on');
end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
if get(hObject,'Value')
    set(handles.checkbox2,'Value',0);
end
% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
if get(hObject,'Value')
    set(handles.checkbox1,'Value',0);
end   
function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global bitsM;
global bitsG;
bitsM = [bitsM num2str(get(hObject,'Value'))];
set(handles.edit5,'String',bitsM);
bitsG = [bitsG 1];
numeroBitsG = length(bitsG);
set(handles.text22,'String',num2str(numeroBitsG));

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global bitsM;
global bitsG;
bitsM = [bitsM num2str(get(hObject,'Value')*0)];
set(handles.edit5,'String',bitsM);
bitsG = [bitsG 0];
numeroBitsG = length(bitsG);
set(handles.text22,'String',num2str(numeroBitsG));



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fc;
global fb;
global Ac;
global M;
global teta;
global Opc;
global N;
global bitsG;
global bitsM;
global ts; ts = 0;
global tb; tb = 0;

bitsG = [];
bitsM = '';
fc = [];
fb = [];
Ac = [];
teta = [];
M = [];
Opc = [];
N = [];
set(handles.edit5,'String','');
set(handles.edit9,'String','');
set(handles.edit8,'String','');
set(handles.edit6,'String','');
set(handles.edit7,'String','');
set(handles.edit2,'String','');
set(handles.popupmenu1,'Value',1);
set(handles.edit10,'String','');
set(handles.edit11,'String','');
set(handles.edit12,'String','');
set(handles.edit13,'String','');
set(handles.edit14,'String','');
set(handles.edit15,'String','');
set(handles.edit16,'String','');
set(handles.text21,'String','Presición');
set(handles.text22,'String','');
set(handles.pushbutton1,'Enable','on');
axes(handles.axes1); cla;
axes(handles.axes2); cla;
axes(handles.axes3); cla;
axes(handles.axes4); cla;
axes(handles.axes5); cla;
clear all; clc;

% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- Executes during object deletion, before destroying properties.
function axes4_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

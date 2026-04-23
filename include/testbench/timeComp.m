% settings
fs = 2e6;% sampling rate
T_test = 1e-3;% code length in time
T_total = 600;% total time in second
loopTimes = round(T_total/T_test);% simulation round
dataLen = round(T_test*fs);% data length
tPromptStart = 0;% start time
tPrompt = tPromptStart : (1/fs) : ((dataLen-1)*(1/fs)  + tPromptStart);% timeaxis
tLateStart = 0;% start time
tLate = tLateStart : (1/fs) : ((dataLen-1)*(1/fs)  + tLateStart);% timeaxis
tEarlyStart = 0;% start time
tEarly = tEarlyStart : (1/fs) : ((dataLen-1)*(1/fs) + tEarlyStart);% timeaxis

% received signal
sig = rand(1,dataLen)+1j*rand(1,dataLen);
sig_r = real(sig);
sig_i = imag(sig);

% local code
sig_p = rand(1,dataLen);
sig_e = rand(1,dataLen);
sig_l = rand(1,dataLen);
% method 1
% complex mutiply complex
tic
for loopCnt = 1:loopTimes
    % local signal
    localSig = exp(1i*2*pi*tPrompt);
    basebandI = real(sig.*localSig);
    basebandQ = real(sig.*localSig);
    I_E = sum(sig_e .* basebandI);
    Q_E = sum(sig_e .* basebandQ);
    I_P = sum(sig_p .* basebandI);
    Q_P = sum(sig_p .* basebandQ);
    I_L = sum(sig_l .* basebandI);
    Q_L = sum(sig_l .* basebandQ);
end
time = toc

% method 2
% IQ mutiply IQ
tic
for loopCnt = 1:loopTimes
    % local signal
    localCos = cos(2*pi*tPrompt);
    localSin = sin(2*pi*tPrompt);

    basebandI = (sig_r.*localCos)+(sig_i.*localSin);
    basebandQ = -(sig_r.*localSin)+(sig_i.*localCos);
    I_E = sum(sig_e .* basebandI);
    Q_E = sum(sig_e .* basebandQ);
    I_P = sum(sig_p .* basebandI);
    Q_P = sum(sig_p .* basebandQ);
    I_L = sum(sig_l .* basebandI);
    Q_L = sum(sig_l .* basebandQ);
end
time = toc

% method 3
% IQ mutiply IQ + matrix integral
tic
for loopCnt = 1:loopTimes
    % local signal
    localCos = cos(2*pi*tPrompt);
    localSin = sin(2*pi*tPrompt);

    basebandI = (sig_r.*localCos)+(sig_i.*localSin);
    basebandQ = -(sig_r.*localSin)+(sig_i.*localCos);
    I_E = (sig_e * basebandI.');
    Q_E = (sig_e * basebandQ.');
    I_P = (sig_p * basebandI.');
    Q_P = (sig_p * basebandQ.');
    I_L = (sig_l * basebandI.');
    Q_L = (sig_l * basebandQ.');
end
time = toc

% method 4
% IQ mutiply IQ + matrix integral
tic
for loopCnt = 1:loopTimes
    % local signal
    localCos = cos(2*pi*tPrompt);
    localSin = sqrt((1+localCos).*(1-localCos));

    basebandI = (sig_r.*localCos)+(sig_i.*localSin);
    basebandQ = -(sig_r.*localSin)+(sig_i.*localCos);
    I_E = (sig_e * basebandI.');
    Q_E = (sig_e * basebandQ.');
    I_P = (sig_p * basebandI.');
    Q_P = (sig_p * basebandQ.');
    I_L = (sig_l * basebandI.');
    Q_L = (sig_l * basebandQ.');
end
time = toc

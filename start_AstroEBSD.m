function Astro_FP=start_AstroEBSD(varargin)
% Load AstroEBSD

%set up the path
local_path = fileparts(mfilename('fullpath'));

fprintf('Loading AstroEBSD');

if MATLABverLessThan('9.0')
    error('AstroEBSD needs at least version 9 of Matlab')
end

%read Astro version from version file - adapted from MTEX
try
  fid = fopen('VERSION','r');
  AstroVersion = fgetl(fid);
  fclose(fid);
  fprintf([' ' AstroVersion '  ']);
catch
  AstroVersion = 'AstroEBSD';
end

%initalise folders as needed


%read the current folder
astroloc=strfind(local_path,'AstroEBSD');

%check that w are in a subfolder
if isempty(astroloc)
    error('Path must be run first from a subfolder of ''AstroEBSD''');
end

%get the file path
Astro_FP=local_path(1:astroloc+8);

%build folders for things if this is a first run
if exist([Astro_FP filesep 'testing'],'dir') ~= 7
    mkdir([Astro_FP filesep 'testing']);
end
if exist([Astro_FP filesep 'outputs'],'dir') ~= 7
    mkdir([Astro_FP filesep 'outputs']);
end
if exist([Astro_FP filesep 'decks'],'dir') ~= 7
    mkdir([Astro_FP filesep 'decks']);
end

%build the paths
addpath([Astro_FP filesep 'gen']);
addpath([Astro_FP filesep 'bin']);
addpath([Astro_FP filesep 'utils']);
addpath([Astro_FP filesep 'phases']);
addpath([Astro_FP filesep 'testing']);
addpath([Astro_FP filesep 'decks']);
addpath([Astro_FP filesep 'outputs']);
addpath([Astro_FP filesep 'plot']);
addpath([Astro_FP]);

disp('AstroEBSD file paths loaded');

end

% check MATLAB version - borrowed from MTEX loader
% --------------------
function result = MATLABverLessThan(verstr)

MATLABver = ver('MATLAB');

toolboxParts = getParts(MATLABver(1).Version);
verParts = getParts(verstr);

result = (sign(toolboxParts - verParts) * [1; .1; .01]) < 0;

end

function parts = getParts(V)
parts = sscanf(V, '%d.%d.%d')';
if length(parts) < 3
  parts(3) = 0; % zero-fills to 3 elements
end
end

function p()
if isempty(lasterr)
  fprintf('.');
end
end

function pathadd(path)
pathCell = regexp(path, pathsep, 'split');
if ispc  % Windows is not case-sensitive
  onPath = any(strcmpi(Folder, pathCell));
else
  onPath = any(strcmp(Folder, pathCell));
end
end
%eof
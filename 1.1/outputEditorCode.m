fid = fopen("XBeachFiles\params.txt");
paramsTXT = textscan(fid, '%s', 'CollectOutput',true, 'Delimiter', '\n');
fclose(fid);
paramsTXT = paramsTXT{1,1};
paramsTXT{4,1} = "%%% Editted parameters: tintp,tintg,tstart,npoints,npointvar,nglobalvar      %%%";
date = string(datetime('now'));

paramsTXT{6,1} = "%%% date: "+date+"                                               %%%";
paramsTXT{7,1} = "%%% Function: params.m and outputEditorGUI                                   %%%";
paramsTXT = string(paramsTXT);
% [trueFalse, indexNo] = ismember("%%% Output variables %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%", paramsTXT);
% if trueFalse == 1
%     paramsTXT(indexNo+2:end,1) = "";
% end
indexNoStart = find(contains(paramsTXT,"%%% Global Variables %%%"));
indexNoEnd = find(contains(paramsTXT,"%%% End of File %%%"));
stringAdded = [" ";"arda";"ufuk";"berkay";"cüneyt"; "aysen"; "ayse";"ahmet";" "];
paramsTXTLatest = [paramsTXT(1:indexNoStart); stringAdded; paramsTXT(indexNoEnd:end,1)];


indexNo = indexNo(2,1);
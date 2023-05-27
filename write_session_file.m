function write_session_file(tlist, filename)
Nsession = length(tlist)-1;
q = '"';
text_body = "";
sessID = fopen(filename,'w');
t0 = tlist(1);
doy0 = day(t0,'dayofyear');
for i = 1 : Nsession
    t = tlist(i);
    doy = floor(doy0 + seconds(t-t0)/86400);
    str = sprintf("%s%03i0%s %s%s%s %s%s%s",...
        q,doy,q,q,datestr(t,'yyyy mm dd'),q,q,datestr(t,'HH MM ss'),q);
    t = tlist(i+1);
    str = sprintf("%s %s%s%s %s%s%s\n",...
        str,q,datestr(t-seconds(1),'yyyy mm dd'),q,q,datestr(t-seconds(1),'HH MM ss'),q);
    text_body = text_body + str;
end

fprintf(sessID,"\nLIST_OF_SESSIONS %i\n",Nsession);
fprintf(sessID,text_body);
fprintf(sessID,"## widget = uniline; check_strlen.1 = 4; numlines = %i\n",Nsession);
fprintf(sessID,"## check_type.3 = time; check_type.5 = time\n");
fprintf(sessID,"\n");
fprintf(sessID,"MSG_LIST_OF_SESSIONS 1 %sList of sessions%s\n",q,q);
fprintf(sessID,"\n");
fprintf(sessID,"# BEGIN_PANEL NO_CONDITION #####################################################\n");
fprintf(sessID,"# SESSION TABLE                                                                #\n");
fprintf(sessID,"#                                                                              #\n");
fprintf(sessID,"#                START EPOCH         END EPOCH                                 #\n");
fprintf(sessID,"#    > ID__ yyyy_mm_dd hh_mm_ss yyyy_mm_dd hh_mm_ss     <                      # LIST_OF_SESSIONS\n");
fprintf(sessID,"#                                                                              #\n");
fprintf(sessID,"# END_PANEL ####################################################################\n");
fclose(sessID);
end

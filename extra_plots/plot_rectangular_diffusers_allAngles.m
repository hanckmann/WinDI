% example_optimise_script
%
% Optimise a windtunnel design following a brute force search approach.
% See comments in the file for more details.
%
% Date:     January 19, 2013
% Version:  1
% Contact:  rinkavdommelen@hotmail.com
% Authors:  Rinka van Dommelen
%           Patrick Hanckmann

%            b     blue          .     point              -     solid
%            g     green         o     circle             :     dotted
%            r     red           x     x-mark             -.    dashdot 
%            c     cyan          +     plus               --    dashed   
%            m     magenta       *     star             (none)  no line
%            y     yellow        s     square
%            k     black         d     diamond
%            w     white         v     triangle (down)
%                                ^     triangle (up)
%                                <     triangle (left)
%                                >     triangle (right)
%                                p     pentagram
%                                h     hexagram

clear all;

clear parts;
clear wind_tunnel;
close all;
 
% %% Create settings
% settings = make_settings();
% settings.checks.do = 0;
% settings.diffuser.enable_max_value_max_degrees = false;
% settings.diffuser.max_loss_coefficient = 1.5;
% 
% %% Start script
% print_info(['Windtunnel optimise script (' mfilename() ')'], settings);
% 
% %% Windtunnel specifications (input)
% wind_tunnel.efficiency_fan      = 0.8;
% wind_tunnel.efficiency_motor    = 0.8;
% wind_tunnel.crosssection_test_section = 1;
% wind_tunnel.velocity_test_section     = 20;
% 
% %% Calculations rectangular
% disp('Calculations rectangular')
% test_results = []; % Test result storage
% testset = 0.2: 0.2 : 40;
% x = [];
% y = [];
% for t_length_center_line = testset
%     parts = [];
%     parts = add_part(wind_tunnel, parts, 'Rectangular diffuser',     'diffuser',              1, 1, 3, 3, 'cross_section_shape', 'rectangle', 'length_center_line', t_length_center_line, 'length_wall', 0); % Only fill in length_center_line OR length_wall, but NOT both!
%     
%     % Number of parts/home/matlab
%     parts_count = length(parts);
%     
%     % Check parts
%     if settings.checks.do
%         check_windtunnel(parts, settings);
%     end
%     
%     % Calculate the part loss coefficient
%     for i = 1:parts_count
%         parts{i} = part_loss_coefficient(parts{i}, settings);
%     end
%     
%     % Calculate the part|total pressure drop
%     wind_tunnel.total_pressure_drop = 0;
%     for i = 1:parts_count
%         parts{i} = part_pressure_drop(parts{i}, settings);
%         wind_tunnel.total_pressure_drop = wind_tunnel.total_pressure_drop + parts{i}.pressure_drop;
%     end
%     
%     % Calculate the part|total loss coefficient ratio (and percentage)
%     wind_tunnel.total_loss_coefficient_ratio = 0;
%     for i = 1:parts_count
%         parts{i} = part_loss_coefficient_ratio(parts{i}, settings);
%         wind_tunnel.total_loss_coefficient_ratio = wind_tunnel.total_loss_coefficient_ratio + parts{i}.loss_coefficient_ratio;
%     end
%     
%     % Calculate the part loss percentage
%     for i = 1:parts_count
%         parts{i}.loss_percentage = 100 / wind_tunnel.total_loss_coefficient_ratio * parts{i}.loss_coefficient_ratio;
%     end
%     
%     % Calculate the total power input
%     wind_tunnel.reserve_factor = settings.total_power_input.reserve_factor;
%     wind_tunnel.power_input = wind_tunnel.reserve_factor * wind_tunnel.total_pressure_drop * wind_tunnel.crosssection_test_section * wind_tunnel.velocity_test_section;
%     
%     % Calculate the fan power
%     wind_tunnel.power_fan = wind_tunnel.power_input / (wind_tunnel.efficiency_fan * wind_tunnel.efficiency_motor);
%     
%     index = length(test_results) + 1;
%     test_results(index).parts = parts;
%     test_results(index).wind_tunnel = wind_tunnel;
%     
%     % to generate the plots
%     x = [x parts{1}.angle_degrees];
%     y = [y parts{1}.loss_coefficient];
% end
% 
% % Clear useless information
% clear i;
% clear parts_count;
% clear wind_tunnel.crosssection_test_section wind_tunnel.velocity_test_section;

%%
% Results measurements of wind tunnels
disp('+ Pre-calculated values and Measurements')

% Barlow
plot1_x = [79.9489740405689, 70.4810530858488, 61.9988063340563, 54.6640630602038, 48.4517737874208, 43.2381400714079, 38.8682974608490, 35.1929055453967, 32.0826660747402, 29.4312385432435, 27.1532703730052, 25.1809382333364, 23.4604571890435, 21.9490680286278, 20.6126049355808, 19.4235925411747, 18.3597784964213, 17.4030078523690, 16.5383596821671, 15.7534828555950, 15.0380825644486, 14.3835210565252, 13.7825051794695, 13.2288402245865, 12.7172346932880, 12.2431444160953, 11.8026472772844, 11.3923418962182, 11.0092651812874, 10.6508248451447, 10.3147438535307, 9.99901444952972, 9.70185990540944, 9.42170254547008, 9.15713688510270, 8.90690696536520, 8.66988714504651, 8.44506575550625, 8.23153113664005, 8.02845966198555, 7.83510543246066, 7.65079137548328, 7.47490153231116, 7.30687435371030, 7.14619685433382, 6.99239950088950, 6.84505172940431, 6.70375800353332, 6.56815433959762, 6.43790523542121, 6.31270094950565, 6.19225508498482, 6.07630243942051, 5.96459708706039, 5.85691066486647, 5.75303083758421, 5.65275992048173, 5.55591364124473, 5.46232002494828, 5.37181838810845, 5.28425842960154, 5.19949940777154, 5.11740939436785, 5.03786459709508, 4.96074874354372, 4.88595252012640, 4.81337306038805, 4.74291347770625, 4.67448243796344, 4.60799376826697, 4.54336609822635, 4.48052253067692, 4.41939033907399, 4.35990068907560, 4.30198838209232, 4.24559161881200, 4.19065178091090, 4.13711322934314, 4.08492311776031, 4.03403121975596, 3.98438976875625, 3.93595330949165, 3.88867856008549, 3.84252428388579, 3.79745117024784, 3.75342172354775, 3.71040015977237, 3.66835231008997, 3.62724553085863, 3.58704861957719, 3.54773173632648, 3.50926633028746, 3.47162507095811, 3.43478178372252, 3.39871138945483, 3.36338984786641, 3.32879410432888, 3.29490203992682, 3.26169242451401, 3.22914487256466, 3.19723980162767, 3.16595839320683, 3.13528255590335, 3.10519489066979, 3.07567865803569, 3.04671774717573, 3.01829664670083, 2.99040041706132, 2.96301466445945, 2.93612551617586, 2.90971959722149, 2.88378400823270, 2.85830630453304, 2.83327447629064, 2.80867692970478, 2.78450246916020, 2.76074028029131, 2.73737991390301, 2.71441127069772, 2.69182458676208, 2.66961041976956, 2.64775963585819, 2.62626339714513, 2.60511314984240, 2.58430061294032, 2.56381776742717, 2.54365684601585, 2.52381032334978, 2.50427090666231, 2.48503152686527, 2.46608533004391, 2.44742566933669, 2.42904609717987, 2.41094035789785, 2.39310238062148, 2.37552627251753, 2.35820631231342, 2.34113694410245, 2.32431277141529, 2.30772855154459, 2.29137919011025, 2.27525973585335, 2.25936537564778, 2.24369142971892, 2.22823334705949, 2.21298670103308, 2.19794718515653, 2.18311060905270, 2.16847289456561, 2.15403007203054, 2.13977827669177, 2.12571374526128, 2.11183281261199, 2.09813190859942, 2.08460755500594, 2.07125636260226, 2.05807502832083, 2.04506033253625, 2.03220913644804, 2.01951837956121, 2.00698507726050, 1.99460631847414, 1.98237926342347, 1.97030114145452, 1.95836924894832, 1.94658094730653, 1.93493366100919, 1.92342487574169, 1.91205213658807, 1.90081304628791, 1.88970526355417, 1.87872650144968, 1.86787452581965, 1.85714715377823, 1.84654225224674, 1.83605773654164, 1.82569156901026, 1.81544175771241, 1.80530635514603, 1.79528345701532, 1.78537120103947, 1.77556776580071, 1.76587136962996, 1.75628026952875, 1.74679276012608, 1.73740717266876, 1.72812187404417, 1.71893526583408, 1.70984578339849, 1.70085189498828, 1.69195210088575, 1.68314493257191, 1.67442895191964, 1.66580275041168, 1.65726494838277, 1.64881419428482, 1.64044916397446, 1.63216856002213, 1.62397111104201, 1.61585557104196];
plot1_y = [1.50000000000000, 1.50000000000000, 1.50000000000000, 1.50000000000000, 1.50000000000000, 1.50000000000000, 1.50000000000000, 1.50000000000000, 1.47942854806806, 1.35677202313841, 1.25143057629957, 1.16025954396826, 1.08076519350964, 1.01096501875201, 0.949274953636062, 0.894421136246111, 0.845371868672072, 0.801285426394863, 0.761470027335999, 0.725353035029142, 0.692457151554347, 0.662381905836564, 0.634789166905152, 0.609391731142618, 0.585944270538614, 0.564236105497362, 0.544085396647259, 0.525334447375553, 0.507845881367273, 0.491499513803298, 0.476189775840949, 0.461823583043511, 0.448318562085652, 0.435601568202677, 0.423607439842998, 0.412277947837467, 0.401560904868057, 0.391409407663111, 0.381781189588339, 0.372638065459946, 0.363945453720141, 0.355671963769945, 0.347789038391067, 0.340270642916557, 0.333092994213517, 0.326234323686157, 0.319674669445386, 0.313395693562601, 0.307380520962200, 0.301613597035217, 0.296080561495484, 0.290768136366145, 0.285664026291195, 0.280756829624538, 0.276035958966332, 0.271491570000088, 0.267114497639726, 0.262896198628219, 0.258828699842370, 0.254904551654785, 0.251116785786850, 0.247458877157594, 0.243924709294588, 0.240508542925841, 0.592733649050834, 0.567070990234489, 0.543437687280049, 0.521624371187353, 0.501447353054339, 0.482745080343380, 0.465375128305249, 0.449211639449468, 0.434143139089936, 0.420070667343908, 0.406906178063509, 0.394571163463898, 0.382995470025764, 0.372116276867847, 0.361877212429285, 0.352227589150074, 0.343121739034843, 0.334518435647066, 0.326380390302420, 0.318673812088208, 0.311368022893570, 0.304435119943825, 0.297849679434086, 0.291588495786647, 0.285630351842350, 0.279955815961550, 0.274547062574958, 0.269387713204812, 0.264462695385734, 0.259758117263654, 0.255261155949506, 0.250959957959913, 0.246843550296239, 0.242901760901732, 0.239125147398592, 0.235504933146566, 0.232032949785323, 0.228701585527288, 0.225503738557981, 0.222432774979374, 0.219482490799912, 0.216647077534143, 0.213921091026581, 0.211299423159497, 0.208777276143764, 0.206350139126329, 0.204013766878119, 0.201764160352701, 0.199597548929288, 0.197510374174209, 0.195499274972974, 0.193561073901031, 0.191692764715332, 0.189891500861303, 0.188154584900774, 0.186479458776237, 0.184863694835412, 0.183304987547826, 0.181801145851953, 0.180350086077540, 0.178949825393203, 0.177598475734215, 0.176294238169752, 0.175035397672728, 0.173820318258851, 0.172647438464602, 0.171515267136692, 0.170422379508007, 0.169367413537344, 0.168349066492272, 0.167366091756261, 0.166417295842910, 0.165501535601562, 0.164617715599976, 0.163764785670922, 0.162941738610682, 0.162147608018449, 0.161381466266503, 0.160642422591900, 0.159929621301134, 0.159242240079925, 0.158579488400924, 0.157940606022657, 0.157324861573590, 0.156731551215636, 0.156159997381878, 0.155609547583657, 0.155079573282567, 0.154569468823195, 0.154078650422769, 0.153606555214154, 0.153152640338886, 0.152716382087179, 0.152297275082035, 0.151894831504824, 0.151508580359843, 0.151138066775565, 0.150782851340427, 0.150442509471153, 0.150116630811751, 0.149804818661440, 0.149506689429864, 0.149221872118088, 0.148950007823931, 0.148690749270317, 0.148443760355379, 0.148208715723153, 0.147985300353751, 0.147773209171999, 0.147572146673546, 0.147381826567555, 0.147201971435110, 0.147032312402525, 0.146872588828821, 0.146722548006630, 0.146581944875870, 0.146450541749559, 0.146328108051157, 0.146214420062885, 0.146109260684484, 0.146012419201908, 0.145923691065488, 0.145842877677100, 0.145769786185931, 0.145704229292431, 0.145646025060072, 0.145594996734558, 0.145550972570142, 0.145513785662730, 0.145483273789462, 0.145459279254484, 0.145441648740628, 0.145430233166753, 0.145424887550483, 0.145425470876113, 0.145431845967462];
% Eckert
plot2_x = [79.9489740405689, 70.4810530858488, 61.9988063340563, 54.6640630602038, 48.4517737874208, 43.2381400714079, 38.8682974608490, 35.1929055453967, 32.0826660747402, 29.4312385432435, 27.1532703730052, 25.1809382333364, 23.4604571890435, 21.9490680286278, 20.6126049355808, 19.4235925411747, 18.3597784964213, 17.4030078523690, 16.5383596821671, 15.7534828555950, 15.0380825644486, 14.3835210565252, 13.7825051794695, 13.2288402245865, 12.7172346932880, 12.2431444160953, 11.8026472772844, 11.3923418962182, 11.0092651812874, 10.6508248451447, 10.3147438535307, 9.99901444952972, 9.70185990540944, 9.42170254547008, 9.15713688510270, 8.90690696536520, 8.66988714504651, 8.44506575550625, 8.23153113664005, 8.02845966198555, 7.83510543246066, 7.65079137548328, 7.47490153231116, 7.30687435371030, 7.14619685433382, 6.99239950088950, 6.84505172940431, 6.70375800353332, 6.56815433959762, 6.43790523542121, 6.31270094950565, 6.19225508498482, 6.07630243942051, 5.96459708706039, 5.85691066486647, 5.75303083758421, 5.65275992048173, 5.55591364124473, 5.46232002494828, 5.37181838810845, 5.28425842960154, 5.19949940777154, 5.11740939436785, 5.03786459709508, 4.96074874354372, 4.88595252012640, 4.81337306038805, 4.74291347770625, 4.67448243796344, 4.60799376826697, 4.54336609822635, 4.48052253067692, 4.41939033907399, 4.35990068907560, 4.30198838209232, 4.24559161881200, 4.19065178091090, 4.13711322934314, 4.08492311776031, 4.03403121975596, 3.98438976875625, 3.93595330949165, 3.88867856008549, 3.84252428388579, 3.79745117024784, 3.75342172354775, 3.71040015977237, 3.66835231008997, 3.62724553085863, 3.58704861957719, 3.54773173632648, 3.50926633028746, 3.47162507095811, 3.43478178372252, 3.39871138945483, 3.36338984786641, 3.32879410432888, 3.29490203992682, 3.26169242451401, 3.22914487256466, 3.19723980162767, 3.16595839320683, 3.13528255590335, 3.10519489066979, 3.07567865803569, 3.04671774717573, 3.01829664670083, 2.99040041706132, 2.96301466445945, 2.93612551617586, 2.90971959722149, 2.88378400823270, 2.85830630453304, 2.83327447629064, 2.80867692970478, 2.78450246916020, 2.76074028029131, 2.73737991390301, 2.71441127069772, 2.69182458676208, 2.66961041976956, 2.64775963585819, 2.62626339714513, 2.60511314984240, 2.58430061294032, 2.56381776742717, 2.54365684601585, 2.52381032334978, 2.50427090666231, 2.48503152686527, 2.46608533004391, 2.44742566933669, 2.42904609717987, 2.41094035789785, 2.39310238062148, 2.37552627251753, 2.35820631231342, 2.34113694410245, 2.32431277141529, 2.30772855154459, 2.29137919011025, 2.27525973585335, 2.25936537564778, 2.24369142971892, 2.22823334705949, 2.21298670103308, 2.19794718515653, 2.18311060905270, 2.16847289456561, 2.15403007203054, 2.13977827669177, 2.12571374526128, 2.11183281261199, 2.09813190859942, 2.08460755500594, 2.07125636260226, 2.05807502832083, 2.04506033253625, 2.03220913644804, 2.01951837956121, 2.00698507726050, 1.99460631847414, 1.98237926342347, 1.97030114145452, 1.95836924894832, 1.94658094730653, 1.93493366100919, 1.92342487574169, 1.91205213658807, 1.90081304628791, 1.88970526355417, 1.87872650144968, 1.86787452581965, 1.85714715377823, 1.84654225224674, 1.83605773654164, 1.82569156901026, 1.81544175771241, 1.80530635514603, 1.79528345701532, 1.78537120103947, 1.77556776580071, 1.76587136962996, 1.75628026952875, 1.74679276012608, 1.73740717266876, 1.72812187404417, 1.71893526583408, 1.70984578339849, 1.70085189498828, 1.69195210088575, 1.68314493257191, 1.67442895191964, 1.66580275041168, 1.65726494838277, 1.64881419428482, 1.64044916397446, 1.63216856002213, 1.62397111104201, 1.61585557104196];
plot2_y = [1.50000000000000, 1.50000000000000, 1.50000000000000, 1.50000000000000, 1.50000000000000, 1.50000000000000, 1.50000000000000, 1.50000000000000, 1.38541965917917, 1.26276313424952, 1.15742168741068, 1.06625065507937, 0.986756304620752, 0.916956129863121, 0.855266064747173, 0.800412247357222, 0.751362979783183, 0.707276537505974, 0.667461138447110, 0.631344146140253, 0.598448262665458, 0.568373016947675, 0.540780278016263, 0.515382842253729, 0.491935381649725, 0.470227216608474, 0.450076507758370, 0.431325558486664, 0.413836992478384, 0.397490624914409, 0.382180886952060, 0.367814694154622, 0.354309673196763, 0.341592679313788, 0.329598550954109, 0.318269058948578, 0.307552015979168, 0.297400518774222, 0.287772300699450, 0.278629176571057, 0.269936564831252, 0.261663074881056, 0.253780149502178, 0.246261754027668, 0.239084105324628, 0.232225434797268, 0.225665780556497, 0.219386804673712, 0.213371632073311, 0.207604708146328, 0.202071672606595, 0.196759247477256, 0.191655137402306, 0.186747940735650, 0.182027070077443, 0.177482681111199, 0.173105608750837, 0.168887309739330, 0.164819810953481, 0.160895662765897, 0.157107896897961, 0.153449988268705, 0.149915820405699, 0.146499654036952, 0.142682601455477, 0.139596367390160, 0.136718207414442, 0.134038966180165, 0.131548845573745, 0.129237730615738, 0.127095433551207, 0.125111874160770, 0.123277210465439, 0.121581930970272, 0.120016917211106, 0.118573483494345, 0.117243399242619, 0.116018898193926, 0.114892677782128, 0.113857891300275, 0.112908134874543, 0.112037430823350, 0.111240208618477, 0.110511284382672, 0.109845839635747, 0.109239399826083, 0.108687813046979, 0.108187229229566, 0.107734080019992, 0.107325059483245, 0.106957105725528, 0.106627383488340, 0.106333267737990, 0.106072328252090, 0.105842315188217, 0.105641145608030, 0.105466890921782, 0.105317765212544, 0.105192114395960, 0.105088406169469, 0.105005220704261, 0.104941242033541, 0.104895250091559, 0.104866113359361, 0.104852782074927, 0.104854281967396, 0.104869708477157, 0.104898221425821, 0.104939040102222, 0.104991438732836, 0.105054742307058, 0.105128322729867, 0.105211595276337, 0.105304015324302, 0.105405075343276, 0.105514302119326, 0.105631254197191, 0.105755519522349, 0.105886713267109, 0.106024475826049, 0.106168470967256, 0.106318384126958, 0.106473920836061, 0.106634805268090, 0.106800778898835, 0.106971599268798, 0.107147038840272, 0.107326883941515, 0.107510933791130, 0.107698999596273, 0.107890903718885, 0.108086478904559, 0.108285567569130, 0.108488021138454, 0.108693699437217, 0.108902470122938, 0.109114208161663, 0.109328795342105, 0.109546119825254, 0.109766075726737, 0.109988562729388, 0.110213485723734, 0.110440754474249, 0.110670283309432, 0.110901990833879, 0.111135799660710, 0.111371636162808, 0.111609430241451, 0.111849115111055, 0.112090627098809, 0.112333905458107, 0.112578892194765, 0.112825531905060, 0.113073771624745, 0.113323560688228, 0.113574850597178, 0.113827594897874, 0.114081749066666, 0.114337270402972, 0.114594117929257, 0.114852252297511, 0.115111635701760, 0.115372231796178, 0.115634005618419, 0.115896923517787, 0.116160953087926, 0.116426063103695, 0.116692223461959, 0.116959405126018, 0.117227580073414, 0.117496721246916, 0.117766802508429, 0.118037798595666, 0.118309685081371, 0.118582438334937, 0.118856035486260, 0.119130454391668, 0.119405673601810, 0.119681672331352, 0.119958430430389, 0.120235928357438, 0.120514147153925, 0.120793068420070, 0.121072674292070, 0.121352947420514, 0.121633870949936, 0.121915428499452, 0.122197604144395, 0.122480382398908, 0.122763748199414, 0.123047686888927, 0.123332184202141, 0.123617226251265, 0.123902799512539, 0.124188890813412, 0.124475487320323, 0.124762576527068, 0.125050146243708, 0.125338184585985, 0.125626679965231];
% Barlow update
plot3_x = [79.9489740405689, 70.4810530858488, 61.9988063340563, 54.6640630602038, 48.4517737874208, 43.2381400714079, 38.8682974608490, 35.1929055453967, 32.0826660747402, 29.4312385432435, 27.1532703730052, 25.1809382333364, 23.4604571890435, 21.9490680286278, 20.6126049355808, 19.4235925411747, 18.3597784964213, 17.4030078523690, 16.5383596821671, 15.7534828555950, 15.0380825644486, 14.3835210565252, 13.7825051794695, 13.2288402245865, 12.7172346932880, 12.2431444160953, 11.8026472772844, 11.3923418962182, 11.0092651812874, 10.6508248451447, 10.3147438535307, 9.99901444952972, 9.70185990540944, 9.42170254547008, 9.15713688510270, 8.90690696536520, 8.66988714504651, 8.44506575550625, 8.23153113664005, 8.02845966198555, 7.83510543246066, 7.65079137548328, 7.47490153231116, 7.30687435371030, 7.14619685433382, 6.99239950088950, 6.84505172940431, 6.70375800353332, 6.56815433959762, 6.43790523542121, 6.31270094950565, 6.19225508498482, 6.07630243942051, 5.96459708706039, 5.85691066486647, 5.75303083758421, 5.65275992048173, 5.55591364124473, 5.46232002494828, 5.37181838810845, 5.28425842960154, 5.19949940777154, 5.11740939436785, 5.03786459709508, 4.96074874354372, 4.88595252012640, 4.81337306038805, 4.74291347770625, 4.67448243796344, 4.60799376826697, 4.54336609822635, 4.48052253067692, 4.41939033907399, 4.35990068907560, 4.30198838209232, 4.24559161881200, 4.19065178091090, 4.13711322934314, 4.08492311776031, 4.03403121975596, 3.98438976875625, 3.93595330949165, 3.88867856008549, 3.84252428388579, 3.79745117024784, 3.75342172354775, 3.71040015977237, 3.66835231008997, 3.62724553085863, 3.58704861957719, 3.54773173632648, 3.50926633028746, 3.47162507095811, 3.43478178372252, 3.39871138945483, 3.36338984786641, 3.32879410432888, 3.29490203992682, 3.26169242451401, 3.22914487256466, 3.19723980162767, 3.16595839320683, 3.13528255590335, 3.10519489066979, 3.07567865803569, 3.04671774717573, 3.01829664670083, 2.99040041706132, 2.96301466445945, 2.93612551617586, 2.90971959722149, 2.88378400823270, 2.85830630453304, 2.83327447629064, 2.80867692970478, 2.78450246916020, 2.76074028029131, 2.73737991390301, 2.71441127069772, 2.69182458676208, 2.66961041976956, 2.64775963585819, 2.62626339714513, 2.60511314984240, 2.58430061294032, 2.56381776742717, 2.54365684601585, 2.52381032334978, 2.50427090666231, 2.48503152686527, 2.46608533004391, 2.44742566933669, 2.42904609717987, 2.41094035789785, 2.39310238062148, 2.37552627251753, 2.35820631231342, 2.34113694410245, 2.32431277141529, 2.30772855154459, 2.29137919011025, 2.27525973585335, 2.25936537564778, 2.24369142971892, 2.22823334705949, 2.21298670103308, 2.19794718515653, 2.18311060905270, 2.16847289456561, 2.15403007203054, 2.13977827669177, 2.12571374526128, 2.11183281261199, 2.09813190859942, 2.08460755500594, 2.07125636260226, 2.05807502832083, 2.04506033253625, 2.03220913644804, 2.01951837956121, 2.00698507726050, 1.99460631847414, 1.98237926342347, 1.97030114145452, 1.95836924894832, 1.94658094730653, 1.93493366100919, 1.92342487574169, 1.91205213658807, 1.90081304628791, 1.88970526355417, 1.87872650144968, 1.86787452581965, 1.85714715377823, 1.84654225224674, 1.83605773654164, 1.82569156901026, 1.81544175771241, 1.80530635514603, 1.79528345701532, 1.78537120103947, 1.77556776580071, 1.76587136962996, 1.75628026952875, 1.74679276012608, 1.73740717266876, 1.72812187404417, 1.71893526583408, 1.70984578339849, 1.70085189498828, 1.69195210088575, 1.68314493257191, 1.67442895191964, 1.66580275041168, 1.65726494838277, 1.64881419428482, 1.64044916397446, 1.63216856002213, 1.62397111104201, 1.61585557104196];
plot3_y = [1.50000000000000, 1.50000000000000, 1.50000000000000, 1.50000000000000, 1.50000000000000, 1.50000000000000, 1.50000000000000, 1.50000000000000, 1.38541965917917, 1.26276313424952, 1.15742168741068, 1.06625065507937, 0.986756304620752, 0.916956129863121, 0.855266064747173, 0.800412247357222, 0.751362979783183, 0.707276537505974, 0.667461138447110, 0.631344146140253, 0.598448262665458, 0.568373016947675, 0.540780278016263, 0.515382842253729, 0.491935381649725, 0.470227216608474, 0.450076507758370, 0.431325558486664, 0.413836992478384, 0.397490624914409, 0.382180886952060, 0.367814694154622, 0.354309673196763, 0.341592679313788, 0.329598550954109, 0.318269058948578, 0.307552015979168, 0.297400518774222, 0.287772300699450, 0.278629176571057, 0.269936564831252, 0.261663074881056, 0.253780149502178, 0.246261754027668, 0.239084105324628, 0.232225434797268, 0.225665780556497, 0.219386804673712, 0.213371632073311, 0.207604708146328, 0.202071672606595, 0.196759247477256, 0.191655137402306, 0.186747940735650, 0.182027070077443, 0.177482681111199, 0.173105608750837, 0.168887309739330, 0.164819810953481, 0.160895662765897, 0.157107896897961, 0.153449988268705, 0.149915820405699, 0.146499654036952, 0.142682601455477, 0.139596367390160, 0.136718207414442, 0.134038966180165, 0.131548845573745, 0.129237730615738, 0.127095433551207, 0.125111874160770, 0.123277210465439, 0.121581930970272, 0.120016917211106, 0.118573483494345, 0.117243399242619, 0.116018898193926, 0.114892677782128, 0.113857891300275, 0.112908134874543, 0.112037430823350, 0.111240208618477, 0.110511284382672, 0.109845839635747, 0.109239399826083, 0.108687813046979, 0.108187229229566, 0.107734080019992, 0.107325059483245, 0.106957105725528, 0.106627383488340, 0.106333267737990, 0.106072328252090, 0.105842315188217, 0.105641145608030, 0.105466890921782, 0.105317765212544, 0.105192114395960, 0.105088406169469, 0.105005220704261, 0.104941242033541, 0.104895250091559, 0.104866113359361, 0.104852782074927, 0.104854281967396, 0.104869708477157, 0.104898221425821, 0.104939040102222, 0.104991438732836, 0.105054742307058, 0.105128322729867, 0.105211595276337, 0.105304015324302, 0.105405075343276, 0.105514302119326, 0.105631254197191, 0.105755519522349, 0.105886713267109, 0.106024475826049, 0.106168470967256, 0.106318384126958, 0.106473920836061, 0.106634805268090, 0.106800778898835, 0.106971599268798, 0.107147038840272, 0.107326883941515, 0.107510933791130, 0.107698999596273, 0.107890903718885, 0.108086478904559, 0.108285567569130, 0.108488021138454, 0.108693699437217, 0.108902470122938, 0.109114208161663, 0.109328795342105, 0.109546119825254, 0.109766075726737, 0.109988562729388, 0.110213485723734, 0.110440754474249, 0.110670283309432, 0.110901990833879, 0.111135799660710, 0.111371636162808, 0.111609430241451, 0.111849115111055, 0.112090627098809, 0.112333905458107, 0.112578892194765, 0.112825531905060, 0.113073771624745, 0.113323560688228, 0.113574850597178, 0.113827594897874, 0.114081749066666, 0.114337270402972, 0.114594117929257, 0.114852252297511, 0.115111635701760, 0.115372231796178, 0.115634005618419, 0.115896923517787, 0.116160953087926, 0.116426063103695, 0.116692223461959, 0.116959405126018, 0.117227580073414, 0.117496721246916, 0.117766802508429, 0.118037798595666, 0.118309685081371, 0.118582438334937, 0.118856035486260, 0.119130454391668, 0.119405673601810, 0.119681672331352, 0.119958430430389, 0.120235928357438, 0.120514147153925, 0.120793068420070, 0.121072674292070, 0.121352947420514, 0.121633870949936, 0.121915428499452, 0.122197604144395, 0.122480382398908, 0.122763748199414, 0.123047686888927, 0.123332184202141, 0.123617226251265, 0.123902799512539, 0.124188890813412, 0.124475487320323, 0.124762576527068, 0.125050146243708, 0.125338184585985, 0.125626679965231];

% x = angle_degrees
x14 = [  0,   2,   3,   5,   6,  10,  15,  20,  25,  30,  35,  40,  50,  90];
plot4 = [.13, .09, .07,.085, .13, .38, .61, .91, .99, .98, .96, .95, .94 ,0.9]; % Cockrell 1963, Ar = 9
plot5 = [.14, .11, .14, .20, .21, .40, .65, .82, .94, .99,1.03,1.03,1.02,1.00]; % Gibson, length = 19m

% old
%c = [.13, .09, .07,.085, .13, .38, .61, .91, .99, .98, .96, .95, .94 ,0.9]; % cockrell 1963, Ar = 9
%b = [];
%d = [.31, .20, .17, .15, .14, .14, .21, .43, .77, 1.05 ]; % gibson Ar = 4
%g = [.14, .11, .14, .20, .21, .40, .65, .82, .94, .99,1.03,1.03,1.02,1.00]; % ?, length = 19m
%h = [.14, .11, .14, .20, .21, .40, .70,1.00,1.14,1.22,1.20,1.11,1.10,1.03]; % ?, length = 6m

% plot the bunch
plot (x14, plot4, 'g--', 'LineWidth',2); hold on;
plot (x14, plot5, 'c--', 'LineWidth',2); 
plot (plot1_x, plot1_y, 'r-', 'LineWidth',2); hold on;
plot (plot2_x, plot2_y, 'b-', 'LineWidth',3); hold on;
plot (plot3_x, plot3_y, 'm--', 'LineWidth',1); hold on;

legend ('Cockrell (measurements)', 'Gibson (measurements)','Barlow', 'Eckert', 'Barlow update');
%title ('Rectangular Diffuser graph Ar=9')
xlabel ('\alpha (degrees)')
ylabel ('K (-)')

ylim([0 1.4])
xlim([0 90])

% Barlow update with the max 1
figure;
plot (plot3_x, min(1, plot3_y), 'r-', 'LineWidth',2);

% legend ('');
%title ('Rectangular Diffuser graph Ar=9')
xlabel ('\alpha (degrees)')
ylabel ('K (-)')

ylim([0 1.1])
xlim([0 90])

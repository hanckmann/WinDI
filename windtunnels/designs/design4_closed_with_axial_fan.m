% example_script
%
% Build the windtunnel by adding relevant parts and their
% information. 
% See comments in the file for more details.
% 
% Expected output:
%     wind_tunnel.crosssection_test_section     % input
%     wind_tunnel.velocity_test_section         % input
%     parts{i}                      % see below
%     total_pressure_drop           % calculated
%     total_loss_coefficient_ratio  % calculated
%     power_input                   % calculated
%     power_fan                     % calculated
%     efficiency_motor              % calculated
%     efficiency_fan                % calculated
%
% Output, the information for specific parts:
%     parts{i}                      % where i is the part number, input and system calculated
% The specific information per part depends on the part type. 
% See the (part specific) functions for their documentation.
%
% Date:     January 20, 2013
% Version:  1.5
% Contact:  rinkavdommelen@hotmail.com
% Authors:  Rinka van Dommelen
%           Patrick Hanckmann

clear all;

clear parts;
clear wind_tunnel;
close all;

%% Create settings
settings = make_settings();
settings.checks.do = 0;
settings.check.type = 'open';
settings.diffuser.enable_max_value_max_degrees = false;

%% Start script
print_info(['Windtunnel optimise script (' mfilename() ')'], settings);

%% Windtunnel specifications (input)
wind_tunnel.efficiency_fan      = 0.8;
wind_tunnel.efficiency_motor    = 0.8;
wind_tunnel.crosssection_test_section = 3;
wind_tunnel.velocity_test_section     = 20;

%% Calculations circular
disp('Design optimisation1')
test_results = []; % Test result storage

%A1_range = [4 : 0.1: 8];
A1_range = 7.5;

%A2_range = [10 : 3 : 16];
A2_range = 15;

%A3_range = [3.25 :0.1 :5.46 ];
A3_range = 4;

%L2_range = [2: 1.5 :5];
L2_range = 0.6;

%-->>>> MENTAL NOTE: THE SUBPLOTS MUST BE THE FIRST TO START THE LOOP!!!!
for L2 = L2_range
    for A2 = A2_range
        for A1 = A1_range
           for A3 = A3_range
                if A1 > A2
                    continue;
                end
                
                parts = [];
                parts = add_part(wind_tunnel, parts, 'Rectangular diffuser'  ,'diffuser'                      , 1.25, 1.25, sqrt(A1), sqrt(A1),                   'cross_section_shape', 'rectangle', 'length_center_line', 10.8, 'length_wall', 0); % Only fill in length_center_line OR length_wall, but NOT both!
                parts = add_part(wind_tunnel, parts, 'Corner'                ,'corner'                        , sqrt(A1), sqrt(A1), sqrt(A1), sqrt(A1),     'chord', .60);
                parts = add_part(wind_tunnel, parts, 'Corner'                ,'corner'                        , sqrt(A1), sqrt(A1), sqrt(A1), sqrt(A1),     'chord', .60);
                
                parts = add_part(wind_tunnel, parts, 'Diffuser'              ,'diffuser'                      , sqrt(A1), sqrt(A1), sqrt(A2), sqrt(A2),     'cross_section_shape', 'rectangle', 'length_center_line', L2, 'length_wall', 0); % Only fill in length_center_line OR length_wall, but NOT both!
                % if the angle of the diffuser is larger than 10 degrees, it will
                % remove the last part (can be changed) and add a Diffuser_BLC and 2 screens
                last_part_number = length(parts);
                tmp_part = parts{last_part_number};
                if (strcmp(parts{last_part_number}.type, 'diffuser'))
                    tmp_part.radius_in      = sqrt((tmp_part.width_in  * tmp_part.height_in) / pi);
                    tmp_part.radius_out     = sqrt((tmp_part.width_out * tmp_part.height_out) / pi);
                    [tmp_part.angle_radian tmp_part.length_center_line] = wall_central_line_angle(tmp_part.radius_in, tmp_part.radius_out, tmp_part.length_wall, tmp_part.length_center_line);
                    tmp_part.angle_degrees = radian2degrees(tmp_part.angle_radian);
                    if(isfield(tmp_part, 'angle_degrees'))
                        if (tmp_part.angle_degrees > 10)
                            parts = remove_part(parts, last_part_number); % Remove old diffuser, and add the new stuff
                            parts = add_part(wind_tunnel, parts, 'Diffuser_BLC' , 'diffuser_with_boundary_layer_control', sqrt(A1), sqrt(A1), sqrt(A2), sqrt(A2),    'length_center_line', L2, 'length_wall', 0); % Only fill in length_center_line OR length_wall, but NOT both!
                            %parts = add_part(wind_tunnel, parts, 'BLC Screen 1' , 'screen'                     , sqrt(A1), sqrt(A1), sqrt(A1), sqrt(A1),   'wire_diameter', 0.001, 'wire_roughness', 1.3, 'cell_diameter', 0.01);
                            parts = add_part(wind_tunnel, parts, 'BLC Screen 2' , 'screen'                     , sqrt((A1+A2)/2), sqrt((A1+A2)/2), sqrt((A1+A2)/2), sqrt((A1+A2)/2),   'wire_diameter', 0.001, 'wire_roughness', 1.3, 'cell_diameter', 0.01);
                            %parts = add_part(wind_tunnel, parts, 'BLC Screen 2' , 'screen'                     , sqrt(A2), sqrt(A2), sqrt(A2), sqrt(A2),   'wire_diameter', 0.001, 'wire_roughness', 1.3, 'cell_diameter', 0.01);
                        end
                    end
                end
                clear last_part_number tmp_part;
                
               
                parts = add_part(wind_tunnel, parts, 'Honeycomb'             ,'honeycomb'                     , sqrt(A2), sqrt(A2), sqrt(A2), sqrt(A2),         'cell_length', 8*(sqrt(A2)/150), 'cell_diameter', (sqrt(A2)/150), 'cell_wall_thickness', .002, 'material_roughness', 8*10^-5);
                parts = add_part(wind_tunnel, parts, 'Screen'                ,'screen'                        , sqrt(A2), sqrt(A2), sqrt(A2), sqrt(A2),         'wire_diameter', 0.0007, 'wire_roughness', 1.3, 'cell_diameter', 0.003);
                parts = add_part(wind_tunnel, parts, 'Screen'                ,'screen'                        , sqrt(A2), sqrt(A2), sqrt(A2), sqrt(A2),         'wire_diameter', 0.0005, 'wire_roughness', 1.3, 'cell_diameter', 0.0015);
                
                parts = add_part(wind_tunnel, parts, 'Curved contraction'    ,'contraction'                   , sqrt(A2), sqrt(A2), 1.5, 2 ,                    'shape' ,'straight', 'center_length', 2.5); % length = length along the center line
                parts = add_part(wind_tunnel, parts, 'Fetch'                 ,'fetch'                         , 1.5, 2, 1.61, 2,                                'length', 12, 'height_testsection',1);
                parts = add_part(wind_tunnel, parts, 'Rectangular diffuser'  ,'diffuser'                      , 1.61, 2 , sqrt(A3), sqrt(A3),                   'cross_section_shape', 'rectangle', 'length_center_line', 0.5, 'length_wall', 0); % Only fill in length_center_line OR length_wall, but NOT both!
                parts = add_part(wind_tunnel, parts, 'Corner downstream ts'  ,'corner_downstream_testsection' , sqrt(A3), sqrt(A3), sqrt(A3), sqrt(A3),         'chord', .40);
                parts = add_part(wind_tunnel, parts, 'Corner'                ,'corner'                       , sqrt(A3), sqrt(A3), sqrt(A3), sqrt(A3),          'chord', .40);
                parts = add_part(wind_tunnel, parts, 'Safety net'            ,'safetynet'                     , sqrt(A3), sqrt(A3), sqrt(A3), sqrt(A3));
                parts = add_part(wind_tunnel, parts, 'Curved contraction'    ,'contraction'                   , sqrt(A3), sqrt(A3), 1.25, 1.25   ,              'shape' ,'straight', 'center_length', 1.2 ); % length = length along the center line
                
                % Number of parts/home/matlab
                parts_count = length(parts);
                
                % Check parts
                if settings.checks.do > 0
                    check_windtunnel(parts, settings);
                end
                
                % Calculate the part loss coefficient
                for i = 1:parts_count
                    parts{i} = part_loss_coefficient(parts{i}, settings);
                end
                
                % Calculate the part|total pressure drop
                wind_tunnel.total_pressure_drop = 0;
                for i = 1:parts_count
                    parts{i} = part_pressure_drop(parts{i}, settings);
                    wind_tunnel.total_pressure_drop = wind_tunnel.total_pressure_drop + parts{i}.pressure_drop;
                end
                
                % Calculate the part|total loss coefficient ratio (and percentage)
                wind_tunnel.total_loss_coefficient_ratio = 0;
                for i = 1:parts_count
                    parts{i} = part_loss_coefficient_ratio(parts{i}, settings);
                    wind_tunnel.total_loss_coefficient_ratio = wind_tunnel.total_loss_coefficient_ratio + parts{i}.loss_coefficient_ratio;
                end
                
                % Calculmate the part loss percentage
                for i = 1:parts_count
                    parts{i}.loss_percentage = 100 / wind_tunnel.total_loss_coefficient_ratio * parts{i}.loss_coefficient_ratio;
                end
                
                % Calculate the total power input
                wind_tunnel.reserve_factor = settings.total_power_input.reserve_factor;
                wind_tunnel.power_input = wind_tunnel.reserve_factor * wind_tunnel.total_pressure_drop * wind_tunnel.crosssection_test_section * wind_tunnel.velocity_test_section;
                
                % Calculate the fan power
                wind_tunnel.power_fan = wind_tunnel.power_input / (wind_tunnel.efficiency_fan * wind_tunnel.efficiency_motor);
                
                index = length(test_results) + 1;
                test_results(index).parts = parts;
                test_results(index).wind_tunnel = wind_tunnel;
            end
        end
    end
end



% Clear useless information
clear i;
clear parts_count;
clear wind_tunnel.crosssection_test_section wind_tunnel.velocity_test_section;


%% Pretty printing
pretty_print(parts, wind_tunnel)

%% search part information via
% parts{x}
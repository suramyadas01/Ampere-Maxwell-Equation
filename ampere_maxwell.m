clc;
clear;
close all;

disp("This is a MATLAB program to visualize a magnetic field created by a current carrying wire.");
disp("A current carrying wire is drawn and a capacitor is also placed to get more scope.");
disp("This MATLAB program aims at demonstrating the Ampere-Maxwell Equation.")
disp("You can choose between two surfaces and the program will show you the magnetic field generated in that surface.");
disp("Then you can input the magnitude of current and radius and the program will draw the required magnetic field for you.")
fprintf('\n');

% ============ Declaring Variables ==================
global mu;
mu = 8.85418782*10^(-12);
global t;
t = 0:0.01:2*pi;     %Pi vector for drawing circles.
global cap_radius; 
cap_radius = 2;     %Radius of capacitor.


%============= Function Declaration ===============
draw_fields = @draw_surface;
draw_blank = @draw_scene;


disp("Enter 1 to choose flat circular surface. ");
disp("Enter 2 to choose curved surface. ");
disp("Enter 3 to display blank setup. ");
disp("Enter 4 to exit.");
choice = input("==> ");
if choice == 3
 draw_scene();
elseif choice == 1 || choice == 2
    draw_surface(choice);
elseif choice == 4
  disp("Goodbye.");
else
     disp("You did not enter valid choice.");
end
    
%This function draws the wire along with the capacitor on which the field lines can later be superimposed.
function draw_scene()
 cap_radius = 2;
 plate_dist = 0.5;    %distance of the plate from the origin.
 t = 0:0.01:2*pi;
 
    ly = [-4:0.1:-0.5];
    ry = [0.5:0.1:4];

    lz = zeros(numel(ly));
    rz = zeros(numel(ly));

    x = cap_radius * cos(t);
    z = cap_radius * sin(t);

    plot3(lz, ly, lz);
    hold on;
    plot3(rz, ry, rz);
    hold on;
    fill3(x,-plate_dist*ones(numel(t)),z,'r');
    hold on;
    fill3(x,plate_dist*ones(numel(t)),z,'b');
    hold on;    
    axis equal;
    grid on;    
 xlabel("X-axis");
 ylabel("Y-axis");
 zlabel("Z-axis");
 title("Blank setup for demonstrating magnetic field lines");
end

%This function is the main element that draws the lines of force.
function draw_surface(choice)
    draw_scene();
 cap_radius = 2;
 plate_dist = 0.5; %distance of the plate from the origin.
 mu = 8.85418782*10^(-12);
 t = 0:0.01:2*pi;
    if choice == 1
        disp("You have chosen a flat surface.");
    elseif choice == 2
        disp("You have chosen a curved surface.");
 end
    radius = input("Enter value of radius:");
    dist = input("Enter location on the wire.(Any number between -10 and 10):");
    current = input("Enter magnitude of current:");
    r = radius/10;
    if choice == 2
        dist = dist - radius;
 end
    for r = radius/10:radius/10:radius
        if abs(dist)>plate_dist && radius<cap_radius
            B = (mu*current)*cap_radius/2*pi*radius*radius; %using special equation for loop inside the capacitor. 
         if r == radius     
    disp("The magnitude of the magnetic field at given settings is: ");
             disp(B);
    end
        else
            B = (mu*current)/2*pi*radius;    %general formula for calculating B
            if r == radius 
                disp("The magnitude of the magnetic field at given settings is: ");
             disp(B);
   end
  end
        Bm = B + zeros(numel(t));        
        x = r.*cos(t);
        z = r.*sin(t);
        y = dist + 0 * sin(t);  
        if choice == 2 
            dist = dist + radius/10 % curvature for curved surface
   end
        u = B.*cos(t + pi/2);
        w = B.*sin(t + pi/2);
        v = 0*sin(t);
                       title("Depiction of magnetic field lines on the given settings.");
        plot3(x,y,z); %drawing the field lines
        axis equal;
 end
end

%% Problem 2
% arrival times
A = [1 5 13 14 21 26 29]';
% service times
S = [6 8 5 6 4 6 7]';
% departure times
D = zeros(7,1);
% indicator
I = zeros(7,1);
t = A(1);
while sum(I) ~= -7
    if ~(I==1) % no customer on the line
        D(abs(sum(I))+1) = A(abs(sum(I))+1) + S(abs(sum(I))+1); % update departure time
        I(abs(sum(I))+1) = 1; % let the customer enter
    end
    if min(A(I == 0)) < min(D(I==1)) % enter
        t0 = t; % record old time
        t = min(A(I == 0)); % update current time
        S(I==1) = S(I==1)-(t-t0)/sum(I(I>0)); % update left service time
        I(A==t) = 1; % let current customer enter
        D(I==1) = t + S(I==1)*sum(I(I>0)); % update the departure time
    else % leave
        t = min(D(I==1)); % update current time
        S(I==1) = S(I==1)-S(D==t); % update left service time
        I(D==t) = -1; % let current customer leave
        D(I==1) = t + S(I==1)*sum(I(I>0)); % update the departure time
    end
end

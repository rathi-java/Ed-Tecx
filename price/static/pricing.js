document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".purchase-btn").forEach(button => {
        button.addEventListener("click", () => {
            const planType = button.id.replace("-btn", "");
            document.getElementById(planType + "-modal").style.display = "flex";
        });
    });

    document.querySelectorAll(".modal-overlay").forEach(modal => {
        modal.addEventListener("click", (e) => {
            if (e.target === modal) {
                modal.style.display = "none";
            }
        });
    });

    function startPayment(amount) {
        fetch(paymentUrl, {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded",
                "X-CSRFToken": csrfToken
            },
            body: new URLSearchParams({ amount: amount })
        })
        .then(response => response.json())
        .then(order => {
            var options = {
                "key": razorpayKey,
                "amount": order.amount,
                "currency": "INR",
                "name": "Reader Club",
                "description": "Subscription Payment",
                "order_id": order.id,
                "image": staticLogoUrl,
                "handler": function (response) {
                    alert("Payment successful! Payment ID: " + response.razorpay_payment_id);
                },
                "prefill": {
                    "name": "Reader Club",
                    "email": "rc@gmail.com",
                    "contact": "1234567890"
                },
                "theme": {
                    "color": "#077BC3"
                }
            };
            var rzp1 = new Razorpay(options);
            rzp1.open();
        })
        .catch(error => console.error("Error:", error));
    }

    window.startPayment = startPayment;
});

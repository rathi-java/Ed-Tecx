// document.addEventListener("DOMContentLoaded", function () {
//     document.querySelectorAll(".purchase-btn").forEach(button => {
//         button.addEventListener("click", () => {
//             const planType = button.id.replace("-btn", "");
//             document.getElementById(planType + "-modal").style.display = "flex";
//         });
//     });

//     document.querySelectorAll(".modal-overlay").forEach(modal => {
//         modal.addEventListener("click", (e) => {
//             if (e.target === modal) {
//                 modal.style.display = "none";
//             }
//         });
//     });

//     function startPayment(amount) {
//         fetch(paymentUrl, {
//             method: "POST",
//             headers: {
//                 "Content-Type": "application/x-www-form-urlencoded",
//                 "X-CSRFToken": csrfToken
//             },
//             body: new URLSearchParams({ amount: amount })
//         })
//         .then(response => response.json())
//         .then(order => {
//             var options = {
//                 "key": "{{ settings.RAZORPAY_KEY_ID }}",
//                 "amount": order.amount,
//                 "currency": "INR",
//                 "name": "Reader Club",
//                 "description": "Subscription Payment",
//                 "order_id": order.id,
//                 "image": "{% static 'images/yearly.png' %}",
//                 "handler": function (response) {
//                     // Optionally, you can pass additional data like the plan ID and amount
//                     fetch("{% url 'payment_success' %}", {
//                         method: "POST",
//                         headers: {
//                             "Content-Type": "application/x-www-form-urlencoded",
//                             "X-CSRFToken": "{{ csrf_token }}"
//                         },
//                         body: new URLSearchParams({
//                             "razorpay_payment_id": response.razorpay_payment_id,
//                             "razorpay_order_id": response.razorpay_order_id,
//                             // "razorpay_signature": response.razorpay_signature, // if needed
//                             "plan_id": "YOUR_PLAN_ID",  // Replace with the actual plan id (e.g., from a data attribute)
//                             "amount": order.amount / 100  // Convert back to rupees if needed
//                         })
//                     })
//                     .then(res => res.json())
//                     .then(data => {
//                         if (data.status === "success") {
//                             alert("Payment successful and subscription updated!");
//                         }
//                     })
//                     .catch(error => console.error("Error:", error));
//                 },
//                 "prefill": {
//                     "name": "Reader Club",
//                     "email": "rc@gmail.com",
//                     "contact": "1234567890"
//                 },
//                 "theme": {
//                     "color": "#077BC3"
//                 }
//             };
//             var rzp1 = new Razorpay(options);
//             rzp1.open();
            
//         })
//         .catch(error => console.error("Error:", error));
//     }

//     window.startPayment = startPayment;
// });
